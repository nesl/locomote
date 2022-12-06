import pandas as pd
import numpy as np
from gtda.time_series import SlidingWindow
import matplotlib.pyplot as plt
from math import atan2, pi, sqrt, atan2, sin, cos, radians, ceil
from scipy.signal import resample
from scipy.fft import fft
from scipy import interpolate
from geographiclib.geodesic import Geodesic
from tqdm import tqdm
import os
import math

def import_marina_dataset(window_size=200,stride=20):
    imu = np.empty([0,9])
    gps_raw = pd.read_csv('gps_data/20221127091054-50175-data.txt',delimiter='\t')
    gps_raw = gps_raw[['longitude','latitude']].to_numpy()
    x_y = long_lat_to_x_y(gps_raw)
    gps = np.zeros([x_y.shape[0]*100,2])
    vel = np.zeros([(x_y.shape[0]*100)-1,2])
    with open('imu_data/imu_list_of_files.txt', 'r') as f:
        list_of_files = [line.strip() for line in f]
    for line in tqdm(list_of_files):
        cur_file = pd.read_csv('imu_data/'+line,header=None)
        cur_file = cur_file[[1,2,3,4,5,6,7,8,9]].to_numpy()
        imu = np.vstack((imu,cur_file))
        
    #resample GPS
    gps[:,0] = resample(x_y[:,0],x_y.shape[0]*100)
    gps[:,1] = resample(x_y[:,1],x_y.shape[0]*100)
    
    #align
    gps = gps[50153:,]
    vel = vel[50153:,]
    
    #extract velocity from GPS
    vel[:,0] = np.diff(gps[:,0])
    vel[:,1] = np.diff(gps[:,1])
    vel = np.insert(vel,0,np.array(([0,0])),axis=0)
    
    #windowing
    windows = SlidingWindow(size=window_size, stride=stride)
    cur_train_3D = windows.fit_transform(imu[:,0])
    for i in range(1,imu.shape[1]):
        X_windows = windows.fit_transform(imu[:,i])
        cur_train_3D = np.dstack((cur_train_3D,X_windows))

    cur_GT_3D = windows.fit_transform(vel[:,0])
    for i in range(1,vel.shape[1]):
        X_windows = windows.fit_transform(vel[:,i])
        cur_GT_3D = np.dstack((cur_GT_3D,X_windows))

    cur_GPS_3D = windows.fit_transform(gps[:,0])
    for i in range(1,gps.shape[1]):
        X_windows = windows.fit_transform(gps[:,i])
        cur_GPS_3D = np.dstack((cur_GPS_3D,X_windows))
    
    #modify 3d velocity and 3D GPS matrix to have only nX1X2 shape
    vel_3D = np.zeros([cur_GT_3D.shape[0],2])
    for i in range(cur_GT_3D.shape[0]): 
        vel_3D[i,0] = np.mean(cur_GT_3D[i,:,0])
        vel_3D[i,1] = np.mean(cur_GT_3D[i,:,1])
    GPS_3D = np.zeros([cur_GPS_3D.shape[0],2])
    for i in range(cur_GPS_3D.shape[0]): 
        GPS_3D[i,0] = np.mean(cur_GPS_3D[i,:,0])
        GPS_3D[i,1] = np.mean(cur_GPS_3D[i,:,1])   
            
            
    #extract physics channel and concatenate with windowed imu data
    
    phy_mat = np.empty((cur_train_3D.shape[0]))
    for i in range(cur_train_3D.shape[0]):
        acc_x =  cur_train_3D[i,:,0]
        acc_y =  cur_train_3D[i,:,1]
        acc_z =  cur_train_3D[i,:,2]
        VecSum = np.sqrt(acc_x**2 + acc_y**2 + acc_z**2)
        VecSum = VecSum - np.mean(VecSum)
        FFT_VS = fft(VecSum)
        P2 = np.abs(FFT_VS/acc_x.shape[0])
        P1 = P2[0:math.ceil(acc_x.shape[0]/2)]
        P1[1:-1-2] = 2*P1[1:-1-2]
        phy_mat[i] = np.mean(P1)      
    P = np.repeat(phy_mat,window_size).reshape((phy_mat.shape[0],window_size,1))
    cur_train_3D = np.concatenate((cur_train_3D,P),axis=2)
    
    #return raw imu, raw GPS, raw velocity, windowed imu/physics, windowed labels (velocity), and windowed GPS data
    return imu, gps, vel, cur_train_3D, vel_3D, GPS_3D


def long_lat_to_x_y(long_lat_mat):
    x_y_mat = np.zeros((long_lat_mat.shape[0],2))
    geod = Geodesic.WGS84
    lat_init = long_lat_mat[0,1]
    long_init = long_lat_mat[0,0]
    for i in tqdm(range(1,long_lat_mat.shape[0])):
        g = geod.Inverse(lat_init,long_init,long_lat_mat[i,1],long_lat_mat[i,0])
        x_y_mat[i,0] = g['s12']*np.sin(np.abs(radians(g['azi1'])))
        x_y_mat[i,1] = g['s12']*np.cos(np.abs(radians(g['azi1'])))
    return x_y_mat
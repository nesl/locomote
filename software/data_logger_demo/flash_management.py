import serial

# port = 'COM13'
port = input("Enter the serial port for the sensor tag: ")
baud_rate = 115200
# filename = 'sensor_data.txt'
filename = input("Enter the filename to write data to: ")
command = input ("Enter command to read (r) or erase (e) the stored data: ")
if (command != 'r' and command != 'e') :
    print("Invalid command entered")
    exit()


try:
    with serial.Serial(port, baud_rate, timeout=5) as ser:
        if (command == 'r'):
            ser.write("r")
            print("Storing file data to {}...".format(filename))
            with open(filename, 'a') as f: # append mode
                # print("File opened")
                while 1:
                    line = ser.readline().decode()
                    if not line:
                        # print("End of file reached")
                        break
                    f.write(str(line))
                # print("File closed")
            print("Units: accel = m/s^2, gyro = g, magneto = uT,")
            print("temperature = degrees C, pressure = mbar, depth = m, altitude = m above sea level")

        elif (command == 'e'):
            ser.write("e")
            print("Erasing stored data...")
    print("Command issued successfully")
except serial.SerialException:
    print("No sensor tag was found at the specified serial port.")
    exit()

# LocoMote: AI-driven Sensor Tags for Fine-Grained Undersea Localization and Sensing

![hardware_setup](hardware.png)
![software_setup](comm_soft.png)

## Paper
https://ieeexplore.ieee.org/abstract/document/10494218/

## Summary
Long-term and fine-grained maritime localization and sensing is challenging due to sporadic connectivity, constrained power budget, limited footprint, and hostile environment. In this paper, we present the design considerations and implementation of LocoMote, a rugged ultra-low-footprint undersea sensor tag with on-device AI-driven localization, online communication, and energy-harvesting capabilities. LocoMote uses on-chip (< 30 kB) neural networks to track underwater objects within 3 meters with ~6 minutes of GPS outage from 9DoF inertial sensor readings. The tag streams data at 2-5 kbps (< 10^-3 bit error rate) using piezo-acoustic ultrasonics, achieving underwater communication range of more than 50 meters while allowing up to 55 nodes to concurrently stream via randomized time-division multiple access. To recharge the battery during sleep, the tag uses an aluminum-air salt water energy harvesting system, generating upto 5 mW of power. LocoMote is ultra-lightweight (< 50 grams), tiny (32x32$x10 mm^3), consumes low power (~330 mW peak), and comes with a suite of high-resolution sensors. We highlight the hardware and software design decisions, implementation lessons, and the real-world performance of our tag versus existing oceanic sensing technologies. 

## Code Architecture
- ```encasement```: contains the ```.stl``` CAD files for the EPU-40 encasement and resin base.
- ```pcb```: contains the altium pcb design files for the main circuit board, and eagle pcb design files for the offline battery charger and pressure sensor board. PCB schematic and board design images are also provided.
- ```software```: contains code for: (a) data logging from all the sensors into the flash, also contains code to toggle data recovery modes from a computer using a Python script (```data_logger_demo```); (b) communication stack for the transmitter and receiver (```piezo_OOK_demo```); (c) PWM demo for piezo (```piezo_PWM_demo```); (d) GPS data logging and power measurement (```GPS```); (e) repository link for developing neural inertial navigation algorithms, as well as Marina Del Rey deployment IMU, GPS dataset; an importer is provided for the dataset (```neural_inertial_navigation```).

## Required items
- Altium Designer (21.x.x or higher) (https://www.altium.com/altium-designer/).
- AutoDesk Eagle (9.6.2 or higher) (https://www.autodesk.com/products/eagle/overview)
- TinkerCad (https://www.tinkercad.com/).
- For developing neural inertial navigation algorithms, check the requirements in ```software/neural_inertial_navigation/tinyodom```.
- MATLAB with all toolboxes installed (R2020a or better).
- Arduino IDE (https://www.arduino.cc/en/software/) with STM32 Core installed (https://github.com/stm32duino/Arduino_Core_STM32). The Arduino libraries required are listed in ```software/arduino_lib_links.txt```.
- Audacity (https://www.audacityteam.org/)
- Hardware: Check the pcb design files and the paper for list of hardware required and purchase links.


## Citation
Please cite this as:

Swapnil Sayan Saha, Caden Davis, Sandeep Singh Sandha, Junha Park, Joshua Geronimo, Luis Antonio Garcia and Mani Srivastava, "LocoMote: AI-driven Sensor Tags for Fine-Grained Undersea Localization and Sensing", in IEEE Sensors Journal, vol. 24, no. 10, pp. 16999-17018, 15 May 2024, IEEE.


## Acknowledgements
 This work was sponsored in part by: the IoBT REIGN Collaborative Research Alliance funded by the Army Research Laboratory under Cooperative Agreement W911NF-17-2-0196; the Air Force Office of Scientific Research under award FA9550-22-1-0193; the CONIX Research Center, one of the centers in Joint University Microelectronics Program, a Semiconductor Research Corporation program sponsored by the Defense Advanced Research Projects Agency; and, the King Abdullah University of Science and Technology through its Sensor Innovation research program.

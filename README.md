# NCodR
Non-coding RNAs (ncRNA) are major players in the regulation of gene expression. However, the identification and classification of ncRNAs are major bottlenecks in understanding their functional roles. This study analyses seven classes of ncRNAs in plants using sequence and secondary structure-based RNA folding measures. Support vector machines employing radial basis function show the highest accuracy in discriminating ncRNAs, and the classifier is implemented as  NCodR. This study will provide a reliable platform for the genome-wide prediction and classification of ncRNAs in plants and enrich our understanding of plant ncRNAs, which may be further used for crop improvements using genome-editing technology.

The repository contains the source code for the automated classification of non-coding RNAs in plants. NcodR can be used in three different ways:

1.  Installing NCodR locally from the source code
2. Using the pre-packaged docker image.
3. Using the webserver.

## 1. Installing NCodR locally from the source code

The prerequisites to intall NCodR  are listed below.  The instructions below in this section are tested on Ubuntu 20.04 and WSL 1 and 2 on Windows 10. 
### 1.1 Prerequesites and Dependencies

#### 1.1.1  Python 3

NCodR uses scripts written in python language. On Ubuntu or ubuntu based Linux systems,  the python interpretor can be installed by using the following command:

```bash
sudo apt install python3
```

#### 1.1.2 The pip module

The pip module is needed for the installation of other modules such as argparse used in the NCodR program. It can be installed using the following command: 

```bash
sudo apt install python3-pip
```

#### 1.1.3. g++  (with  C++ Standard Template Library C++17/C++20)

Three of the programs available in this repository are written in C++. A compiler with STL 17 or 20 support is needed for compiling the programs from the source. The compiler and the other dependencies can be installed using the following command:

```bash
sudo apt install build-essential
```

#### 1.1.4. Java 

The javac compiler is needed for running the repeats program available in the repository. It can be installed by the following command.

```bash
sudo apt install default-jdk
```

#### 1.1.5. Perl

The perl interpretor is required for both genRNAstats.pl and ViennaRNA package. The perl interpretor is installed already along with the build-essential package in step 1.1.3

#### 1.1.6. Argparse (python library)

The python module argparse is requred for the python programs available in the NCodR package. The module can be installed by the followung command:

```bash
sudo python3 -m pip install argparse
```
### 1.2  Third-party tools

The NCodR packages uses three third party softwares which can be installed by following the instructions below:

#### 1.2.1 ThunderSVM

ThunderSVM is a GPU implemention of libsvm program to train and predict using SVM classifier. The detailed instructions for installation can be found at the following  URL:

  https://github.com/Xtra-Computing/thundersvm

The libsvm  (svm-predict) can be used as an alternative to ThunderSVM in case of difficulties in installation. The libsvm predicttion tool can be installed by using the following command:

```bash
sudo apt install libsvm-tools
```

#### 1.2.2. ViennaRNA

The python bindings provide by the ViennaRNA program is for prediction of the second structure and to calcualate the MFEI values. The perl bindings provided by the package is used by genRNAstas program. For detailed instructions on installation of the package please refer to URL:

 https://github.com/ViennaRNA/ViennaRNA/#installation

  NCodR package imports the python module provided by ViennaRNA. Therefore, after installation of ViennaRNA it is important to make sure that ```RNA``` module is included in the ```PYTHONPATH```. Generally ```RNA``` directory is located at ```/usr/local/lib/python3.8/site-packages/```.  In that case, please include the following path in ```.bashrc``` (or in ```.bash_profile```).  

For a system-wide installation of the ViennaRNA package along with both perl and python binding the precompiled deb package files can be downloed and used. For example to install the ViennaRNA 2.4.17, download the five files: perl-rna_2.4.17-1_amd64.deb, python-rna_2.4.17-1_amd64.deb, viennarna-dev_2.4.17-1_amd64.deb, python3-rna_2.4.17-1_amd64.deb and viennarna_2.4.17-1_amd64.deb.  Place the packages in  a new folder and run the following commands to install.

```bash
sudo dpkg -i *.deb
sudo apt -f install
```

#### 1.2.3. genRNAStats.pl 

The genRNAstats program is available at the following URL: 
https://web.bii.a-star.edu.sg/~stanley/Suppl_material4/genRNAStats.pl)
However, the modified version (to reduce the verbosity)  of  ```genRNAStats.pl``` is provided with the package. Therefore, it is not necessary to download the original souce code.

### 1.3 Compilation and setting up  of NCodR

#### 1.3.1. Download  the NCodR source code

The NCodR source can be downloaded from this git repository.  The download button provides four different types of archives. Download one of them and extract the contents. Alternatively, the following command can be used to clone the repository:

```bash
git clone https://gitlab.com/sunandanmukherjee/ncodr.git
```

If the git program can be installed using the command:
```bash
sudo apt install git
```

#### 1.3.2 Compilation of the source files.

Once the repository is downloaded and extraacated or cloned change the current path to extracted to cloned directory. The source files can be compiled by running the make command. 

```bash
make
```

Upon successful complilation it will create a new ```bin``` directory.  The bin directory contains three excecutable files: calc_AU_MFEI, collapse_hash and repeats.  The details on the excecution and use of the program is detailed in section 1.5.

#### 1.3.3 Setting up the environmental variable
The path to NCodR scripts and excecutables are used by the various programs internally. This needs to set up as an environmental variable. In order to set up this for the ```bash``` shell  export the ```NCODR_HOME``` variable to the .bashrc file by running the the following command from the root of the ```ncodr``` directory or repository:

```bash
echo export NCODR_PATH=$(pwd)>>~/.bashrc
```

In order to access the program from other directories the path needs to be added to the environmental variable. FIn order to set up this for the ```bash``` shell  export the ```PATH``` variable to the .bashrc file by running the the following command from the root of the ```ncodr``` directory or repository:

```bash
 echo export PATH='$PATH':$(pwd) >>~/.bashrc
```

For the changes to effect in the current shell the .bashrc file needs to be sourced again. This step is not necessary if a new shell environment is opened after running the above commands.

```bash
source ~/.bashrc
```

### 1.4 Running NCodR locally

NCodR can be used as a standalone tool. However, to run it locally, the dependencies and the thrid party tools should be installed/downloaded.

#### 1.4.1 Usage

The NCodR package can be run by using the NCodR.py program available in the root of the repository. The program needs a mandatory input file provided as argument. The input file is fasta formatted RNA sequence file. However, if the sequences contains letter T, it will be considered as U during the processing. Upon successful completion, the program will print the output in the terminal. Additionally, output will also be saved in a text file with ```.ncodr``` extension. 

Example use. 

```
        NCodR.py <input file>
```

The following arguments are available with the program:

```
        positional arguments:
          input                 Input file name [RNA sequences in fasta format].

        optional arguments:
          -h, --help            show this help message and exit
          -r, --redundant       remove redundant sequence [default = OFF]
          -c, --clean           clean the intermediate files [default = ON]
          -o OUTPUT, --output OUTPUT
                                Output file name [<input>.ncodr if not provided]

```

#### 1.4.2 Test run

A sample dataset is provided in the ```examples/``` directory, which can be used for a test run. For a quick test run, type the following command from the terminal:

```
./NCodR.py examples/test.fa
```

This should print the prediction results on the screen, as well as generate a file ```(test.fa.ncodr)``` with the prediction results.

### 1.5 Use of additional utilities provided with the package

#### 1.5.1 Preparing the input fasta files
For a fasta file the first step is to convert it to single line format using makeFasta1line.py.  The program takes a multiline multisequence fasta file and to multisequence singleline fasta file. Both filenames are required as positional arguments.

```bash
./makeFasta1line.py <input.fa> <output.fa>
```

#### 1.5.2 Removal of duplicate sequences
The collapse_hash program can be used to remove the repeated sequences in the file.  To remove duplicate sequences from the fasta files using collapse_hash, the input file is a list with the absolute or relative paths of the sequence files. The program runs for all the sequence files to remove the duplicates from all the files. The first sequence entery is retained when duplicates are encountered. The input file is assumed to be in a multiple sequence fasta file. For each sequence a fasta header followed by the sequence in a single line is expected. This program is optional in the pipeline.  This can be very useful while processing big fasta files with redundant sequences. 

```bash
collapse_hash list_file
```

For list file contains the names off the fasta files (single line). 
Example:

```
fasta_file_name_1
fasta_file_name_2
.
.
.
fasta_file_name_n
```

#### 1.5.3 Calculation of AU and MFEI values

 The AU and MFEI values are calcualted using the ```calc_AU_MFEI``` program. The program takes secondary structure file in dot-bracket format (.b) as input. The output filename is an optional positional argument.  

```bash
calc_AU_MFEI <dot_bracket_file> [<tsv_file_with_AU_MFEI>]
```

The RNAfold program can be run to generate the secondary structure file in dot-bracket format (.b)

```bash
RNAfold -d2 --noLP --noPS <fasta_file > > <dot_bracket_file>
```

#### 1.5.4 Calculation of k-mer repeats of length three

The number of repeats for k-mer of length two to six can be calculated using the ```repeats``` program.  The program takes the fasta file as input and the file name should be provided as a positonal argument.

```bash
repeats <input_file_name> 
```
The program generates six output files windowsize1.tsv, windowsize2.tsv, windowsize3.tsv, windowsize4.tsv, windowsize5.tsv and windowsize6.tsv with k-mer repeats of length two to six, respectively. 

#### 1.5.5 Calculation of Npb,NQ and ND values

The genRNAStats.pl can be used for calculation of the parameters normalized base-pairing distance (ND), normalized base-pairing propensity (Npb), and normalized Shannon entropy (NQ).  The program takes single line fasta file as input and can be provided as argument using ```-i```. The output file is a tsv file with the parameters and the file name can be supplied using the argument ```-o````. 

```bash
/genRNAStatsNC.pl -i  <fasta_file> -o <tsv_file>
```

#### 1.5.6  Comparison between different machine learning techniques
Eight different classification algorithms were compared to select the best approach. It is implemented in ```model_comparison.py``` script. Classification algorithms are used as implemented in Scikit learn module.
Following python libraries needed to be installed to run these scripts:
1. Numpy 
2. Scikit learn
3. Pickle
4. Joblib
5. Matplotlib
The python modules can be installed used the following command:

```bash
sudo python3 -m pip install numpy scipy joblib matplotlib
```

## 2. Using the precompiled docker container

The docker image with all the requirements preinstalled and all the programs precompiled is available at the following dockerhub URL:
https://hub.docker.com/r/nithinaneesh/ncodr/

The image can be pulled from the dockerhub using the following command:

```bash
docker pull nithinaneesh/ncodr
```
The docker image can be used with input fasta file in the present working directory using the following the command:

```bash
docker run -v $(pwd):/WORK -u $(id -u ${USER}):$(id -g ${USER}) ncodr  <input file>
```

All the arguments for NCodR.py as listed in 1.4.1 are accepted by the docker image.

If the docker program is not installed already, it can be insatlled and setup using the following set of commands:

```bash
sudo apt install docker.io
```

If the docker program shows permisison errors while running the pull command, the following commands may be helpful to resolve the situation.

```bash
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl restart docker
```

## 3. Using the web server

The web server is available at the following URL:
http://www.csb.iitkgp.ac.in/applications/NCodR/index.phpwww.csb.iitkgp.ac.in/applications/NCodR/index.phpppp
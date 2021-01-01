# NCodR
Non-coding RNAs (ncRNA) are major players in the regulation of gene expression. However, the identification and classification of ncRNAs are major bottlenecks in understanding their functional roles. This study analyses seven classes of ncRNAs in plants using sequence and secondary structure-based RNA folding measures. Support vector machines employing radial basis function show the highest accuracy in discriminating ncRNAs, and the classifier is implemented as  NCodR. This study will provide a reliable platform for the genome-wide prediction and classification of ncRNAs in plants and enrich our understanding of plant ncRNAs, which may be further used for crop improvements using genome-editing technology.

The repository contains the source code for the docker image for automated classification of non-coding RNAs in plants.

# Using the precompiled docker container

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

All the arguments for NCodR.py as listed in 1.4.1 are accepted by the docker image. The following arguments are available with the program:

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
 

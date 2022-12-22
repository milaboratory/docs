# Installation

The latest releases can be obtained from our GitHub:

: [https://github.com/milaboratory/mixcr/releases/](https://github.com/milaboratory/mixcr/releases/)

The latest development pre-builds can be downloaded from: 

: [https://link.milaboratory.com/software/mixcr/mixcr-develop.zip](https://link.milaboratory.com/software/mixcr/mixcr-develop.zip)


## Linux / MacOS

### Manual installation

Download and extract `mixcr`: 

1. Create a folder where you want to install MiXCR and navigate to that folder. Bellow is the command that creates `mixcr` folder in your home directory.

    ```bash
    > mkdir ~/mixcr
    > cd ~/mixcr
    ```

2. Go to [MiXCR GitHub page](https://github.com/milaboratory/mixcr) and copy the link for latest build. The command bellow downloads MiXCR v4.1.2. For other builds replace the link with the one you obtained from GitHub.

    ```shell
    wget https://github.com/milaboratory/mixcr/releases/download/v4.1.2/mixcr-4.1.2.zip
    ```

3. Unpack the zip archive using the `unzip` command

    ```shell
    > unzip mixcr-4.1.2.zip
    ```
    The output looks similar to this:
    ```shell
    Archive:  mixcr-4.1.2.zip
      inflating: mixcr
      inflating: LICENSE
      inflating: mixcr.jar
    ```

4. Check that `mixcr` works with the following command

    ```shell
    > ~/mixcr/mixcr -v
    ```
    
    The output should look similar to:

    ```shell
    MiXCR v (built Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; branch=tag-rework-2; host=Dmitrys-MacBook-Pro-2.local)
    RepSeq.IO v1.4.1-1-master (rev=474ebe0f6e)
    MiLib v2.0.0-11-master (rev=ca59a3ad71)
    Built-in V/D/J/C library: repseqio.v2.0
    ```

Add MiXCR to your `$PATH`:

1. MiXCR is now installed. To run it requires entering the path to the executable command on the command line. We want to be able to run MiXCR by simply entering the word `mixcr` on the command line. To accomplish this, we add it to your $PATH variable. Go into the directory where you unpacked `mixcr` and enter `pwd`.
   ```shell
   > cd ~/mixcr/
   > pwd
   ```
   The output will be the full path to MiXCR directory
   ```shell
   /home/user/mixcr
   ```

   
2. Then use the export command to add it into the $PATH variable.
   ```shell
   export PATH=/home/user/mixcr:$PATH
   ```

    !!! note "Add export to bash.rc file"
          It is better to add that command to your `.bashrc` file, so you won't have to repeat it every time you start a new session.
          ```
          echo "export PATH=/home/user/mixcr:$PATH" >>  ~/.bashrc 
          ```

### Anaconda package

MiXCR has [Anaconda repository](https://anaconda.org/milaboratories/mixcr) to simplify installation of MiXCR using `conda` package manager. To install the latest stable MiXCR build with conda run:

```shell
> conda install -c milaboratories mixcr
```

to install a specific version run:

```shell
> conda install -c milaboratories mixcr=3.0.12
```

`mixcr` package specifies `openjdk` as a dependency, if you already have Java installed on your system, it might be a good idea to prevent conda from installing another copy of JDK, to do that use `--no-deps` flag:

```shell
> conda install -c milaboratories mixcr --no-deps
```

### Homebrew formula

MiXCR has a [Homerew formula](https://github.com/milaboratory/homebrew-all) to simplify installation of MiXCR using `brew` package manager.To install the latest stable MiXCR build with brew run:


```shell
> brew tap milaboratory/all
> brew install mixcr
```

## Windows

1. Go to [MiXCR GitHub page](https://github.com/milaboratory/mixcr) and download the latest build.

2. Unpack the zip archive in the folder where you want MiXCR to be installed. You will see several file:

    For demonstration purposes lets use `C:\mixcr\` folder.
   
    ```shell
    mixcr
    LICENSE
    mixcr.jar
    ```

3. Open terminal and execute the following command
    
    ```shell
   java -jar C:\mixcr\mixcr.jar -v
    ```

4. If everything is fine you will see an output similar to:

    ```shell
    MiXCR v (built Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; branch=tag-rework-2; host=Dmitrys-MacBook-Pro-2.local)
    RepSeq.IO v1.4.1-1-master (rev=474ebe0f6e)
    MiLib v2.0.0-11-master (rev=ca59a3ad71)
    Built-in V/D/J/C library: repseqio.v2.0
    ```

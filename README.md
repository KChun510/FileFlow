# File Queue System

## Description
A lightweight, command-line tool for managing and processing file queues efficiently. Designed for simplicity, flexibility, and seamless integration into existing workflows.

---

## Table of Contents
1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Flags and Options](#flags-and-options)
5. [Examples](#examples)
6. [Integration](#integration)

---

## Features
- Manage file queues through the command line.
- Add, delete, and list files in the queue.
- Load and process queue entries dynamically.
- Supports CSV-based storage for easy integration.

---

## Installation
```bash
git clone https://github.com/KChun510/FileFlow.git
cd FileFlow
chmod +x qSystem.sh
```

---

## Usage
```bash
./qSystem.sh <cont_dir> <fileName> <postDate> <postTime>
# or
./qSystem.sh <cont_dir> # Semi-guided process.
# or
./qSystem.sh           # Fully guided process.
```

---

## Flags and Options
```bash
Fields/CLI args:
<cont_dir>        Directory name where the file is located.
<fileName>        Name of the file within the directory.
<postDate>        Format: mm/dd/yyyy -or- "now"
<postTime>        Format (24hr): hh:mm:ss -or- "now"

Flags:
-listQ            List queued files.
-list <dir_name>  Returns filenames + creation date/time.
-del <Filename>   Delete an entry via filename.
-h                List help text.
```

---

## Examples

Below are a few examples of how to use the `qSystem.sh` script in different environments.

### Example 1: Basic Usage
Run the script with the required arguments:

```bash
./qSystem.sh /path/to/container data.txt mm/dd/yyyy 14:00
```

### Example 2: Guided/Semi-Guided Usage

```bash
./qSystem.sh <cont_dir> # Semi-guided process.
# or
./qSystem.sh           # Fully guided process.
```

### Example 3: List Your File Queue

```bash
./qSystem.sh -listQ
```

#### Output Example
```
Account Name: "test_twitch"
Filename:  "SpunkyObliviousFiddleheadsPeoplesChamp-q3BxZQ4CqIPZ_FOZ000.mp4"
Post Date:  "now"
Post Time:  "now"
-------------------------
Account Name: "test_twitch"
Filename:  "YummyDreamySaladUnSane-V4njwOxQU_LnfYUE000.mp4"
Post Date:  "now"
Post Time:  "now"
-------------------------
```

---

## Integration

To adapt the tool to your environment, follow these steps:

1. **Locate the Script File**:
   - Open the `qSystem.sh` script file in a text editor (e.g., `vim`, `nano`, or VSCode).

2. **Update the Global Variables**:
   - In the script file, you will find the following global variables. Modify them to match your environment:
     - **`CONT_DIR`**: The directory where your container files are stored.
   
3. **Locate the Switch Case**:
   - Open the script file (`qSystem.sh`) and search for the switch-case block. This block will look like the following:

     ```bash
     case $some_variable in
         option1)
             # code for option1
             ;;
         option2)
             # code for option2
             ;;
         *)
             # default case
             ;;
     esac
     ```
   - Update the option names to match the names of your directories in `CONT_DIR` and file paths.

4. **Locate the CSV Script File**:
   - Open the `csvActions.sh` script file in a text editor (e.g., `vim`, `nano`, or VSCode).

5. **Update the Global Variables**:
   - In the script file, you will find the following global variables. Modify them to match your environment:
     - **`header`**: Change to your desired headers for your CSV file. ( If you update the header, you'll also want to edit the read/write/display fn's to match. )

---



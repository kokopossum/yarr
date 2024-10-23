
# rawrRAR

This script extracts `.rar` files from a specified source directory to a destination directory using `7z`. It supports both verbose output and parallel extraction.

## Usage

```bash
./rawrrar.sh -s <source_directory> -d <destination_directory> [-v] [-p]
```

### Options

- `-s <source_directory>`: Specify the source directory containing `.rar` files (required).
- `-d <destination_directory>`: Specify the destination directory where extracted files will be stored (required).
- `-v`: Enable verbose output (optional).
- `-p`: Disable parallel extraction (optional).

## Requirements

- `p7zip` must be installed on your system. You can install it using your package manager. For example, on Ubuntu, you can run:
  ```bash
  sudo apt-get install p7zip-full
  ```

## Example

To extract `.rar` files from `~/Downloads` to `~/Documents/Extracted`, run:

```bash
./rawrrar.sh -s ~/Downloads -d ~/Documents/Extracted
```

## Notes

- The script will create the destination directory if it does not exist.
- If no `.rar` files are found in the source directory, the script will exit without error.
- The script uses parallel processing to extract multiple `.rar` files simultaneously. You can disable this feature with the `-p` option.



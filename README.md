# MISP Lookup Tool

## Description
The MISP Lookup Tool is a PowerShell script designed to facilitate bulk IP address lookups within MISP (Malware Information Sharing Platform) instances. It provides a convenient graphical interface for users to input parameters, execute queries, and export results for further analysis.

This tool streamlines the process of querying MISP for information about a large number of IP addresses at once, which is particularly useful for security analysts, threat intelligence researchers, and network administrators dealing with potentially malicious IPs.

## Key Features
- **Bulk IP Lookup**: Input a list of IP addresses in a TXT file and query MISP for information about each IP in bulk.
- **Export Results**: Save the results of the IP lookups to a CSV file for offline analysis and reporting.
- **Graphical Interface**: User-friendly interface with text fields and buttons for easy interaction.
- **Error Handling**: Provides warnings and error messages for missing input fields or failed queries.

## Usage
1. **Input File Selection**: Specify the path to the TXT file containing the list of IP addresses you want to query. Click on the "Browse" button to navigate to the file location.
2. **Export File Location**: Choose the path where you want to save the CSV file containing the results of the IP lookups. Again, use the "Browse" button to select the desired location.
3. **MISP API Configuration**: Enter the MISP API key and URL of the MISP instance you want to query. These credentials are necessary for authentication and accessing the MISP data.
4. **Initiate Lookup**: Once all the required fields are filled, click on the "Search" button to start the bulk IP lookup process.
5. **Monitor Progress**: The progress bar and label display the current status of the lookup process, indicating the number of IP addresses processed out of the total count.
6. **Result Notification**: Upon completion, a message box notifies you that the search is completed, and the results are saved to the specified CSV file.

## Installation
1. **Clone Repository**: Clone this repository to your local machine using Git, or download the `MISPLookup.ps1` script file directly.
2. **Ensure PowerShell Execution Policy**: Ensure that PowerShell execution policy allows running scripts. You may need to set it to RemoteSigned or Unrestricted for the script to execute without issues.
3. **Run Script**: Execute the `MISPLookup.ps1` script by running it in PowerShell. You can double-click the file or use the PowerShell command line to run it.

## Screenshots



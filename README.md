# MISP Lookup Tool

## Description
The MISP Lookup Tool is a PowerShell script designed to facilitate bulk IOCs lookups within MISP (Malware Information Sharing Platform) instances. It provides a convenient graphical interface for users to input parameters, execute queries, and export results for further analysis.

This tool streamlines the process of querying MISP for information about a large number of IOCs at once, which is particularly useful for security analysts, threat intelligence researchers, and network administrators dealing with potentially malicious IOCs.

## Key Features
- **Bulk IOCs Lookup**: Input a list of IOCs in a TXT file and query MISP for information about each IOC in bulk.
- **Export Results**: Save the results of the IOCs lookups to a CSV file for offline analysis and reporting.
- **Graphical Interface**: User-friendly interface with text fields and buttons for easy interaction.
- **Error Handling**: Provides warnings and error messages for missing input fields or failed queries.

## Screenshots
![image](https://github.com/muhammadtalaat/MISP-Lookup-Tool/assets/167099589/56ecb47a-8b5c-4dac-938f-177edfb168de)

## Usage
1. **Input File Selection**: Specify the path to the TXT file containing the list of IOCs you want to query. Click on the "Browse" button to navigate to the file location.
2. **Export File Location**: Choose the path where you want to save the CSV file containing the results of the IOCs lookups. Again, use the "Browse" button to select the desired location.
3. **MISP API Configuration**: Enter the MISP API key and URL of the MISP instance you want to query. These credentials are necessary for authentication and accessing the MISP data.
4. **Initiate Lookup**: Once all the required fields are filled, click on the "Search" button to start the bulk IOCs lookup process.
5. **Monitor Progress**: The progress bar and label display the current status of the lookup process, indicating the number of IOCs processed out of the total count.
6. **Result Notification**: Upon completion, a message box notifies you that the search is completed, and the results are saved to the specified CSV file.

## Installation
1. **Clone Repository**: Clone this repository to your local machine, or download the `MISP_Lookup.ps1` script file directly.
2. **Ensure PowerShell Execution Policy**: Ensure that PowerShell execution policy allows running scripts. You may need to set it to RemoteSigned or Unrestricted for the script to execute without issues.
3. **Run Script**: Execute the `MISP_Lookup.ps1` script by running it in PowerShell `.\MISP_Lookup.ps1` on downloaded path.

## References
1. https://www.misp-project.org/openapi/
2. https://www.circl.lu/doc/misp/automation/
3. https://docs.virustotal.com/docs/misp-connector

# HelloID-Task-SA-Source-TOPdesk-PersonSearch

## Prerequisites

- [ ] User-defined variable `topdeskApiSecret` created in your HelloID portal. Containing the Topdesk Api Secret.
- [ ] User-defined variable `topdeskApiUsername` created in your HelloID portal. Containing the Topdesk Api Username.
- [ ] User-defined variable `topdeskBaseUrl` created in your HelloID portal. Containing the Topdesk URL, for example: `https://<yourcompany>.topdesk.net`

## Description

This code snippet executes the following tasks:

1. Define a search value `$searchValue` based on the search parameter `$datasource.searchUser`
2. Creating authorization headers
3. `GET` persons that start with `$searchValue`. Default `FIQL queries` that are used are:
   1. employeeNumber
   2. surName
   3. firstName
   4. email
   5. networkLoginName

> For more information about Topdesk  `FIQL queries`
> https://developers.topdesk.com/explorer/?page=supporting-files#/Persons/retrievePersons
> https://developers.topdesk.com/tutorial.html

4. Return a hash table for each Topdesk person using the `Write-Output` cmdlet.
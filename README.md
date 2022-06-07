# VolumeAnalizer.ps1

## Descrizione
Questo script analizza una determinata directory in modo recursivo analizzando ogni file e facendo una statistica finale in base all'estensioni dei file analizzati. È possibile passare come parametri: 

 -  **-path**: che andrà ad indicare la cartella da analizzare (in caso non venisse messa verrà presa la posizione corrente dell'utente)
 - **-filterType**: che indicherà la tipologia di filtro, che può essere unicamente **E** (esclusivo) oppure **I** (inclusivo).  Se specifichiamo **I** come **-filterType** verranno prese in considerazione __solo__ le estensioni specificate nel parametro seguente, altrimenti con **E** verranno **escluse** e quindi ignorate dallo script. Nel caso non venisse messo niente oppure venisse messo un valore sbagliato verrà fatta un analisi completa prendendo in considerazione **tutti** i file.
 - **-filter**: in questo parametro possiamo specificare una serie di estensioni che fungeranno da filtro in base al parametro precedente. Le estensioni vanno scritte così: `-filter .txt,.sql`
 
Viene ritornata una tabella con le seguenti informazioni:
 - l'estensione analizzata
 - la quantità di file trovati con quell'estensione (decimale)
 - la quantità di file trovati con quell'estensione (%)
 - il peso complessivo di tutti i file con quell'estensione in KB
## Sintassi
```powershell
.\VolumeAnalizer.ps1 [-path] <string> [-filterType] <char> [-filter] <string[]> 
```
## Come utilizzarlo
Alcuni esempi di utilizzo su questa cartella:
```powershell
C:\Users\stefano\Desktop\test>
│   collegamento1.lnk
│   file1.txt
│   file2.txt
│   file3.html
│   noextensionfile
│
├───cartella1
│       noextensionfile
│
├───cartella2
│       file1.txt
│       file2.txt
│
├───cartella3
└───cartella4
        file3.html
        noextensionfile
```
### Senza parametri
Il primo modo per lanciare lo script è senza parametri, in questo modo verrà analizzata la cartella corrente dell'utente prendendo in considerazione tutti i tipi di file (senza alcun filtro)
#### Input
```powershell
.\VolumeAnalizer.ps1 
```
#### Output 

```powershell
Folders:  4
Files:  10


Name  Qty Qty_% Size_KB
----  --- ----- -------
.lnk    1    10    0.86
.txt    4    40       0
.html   2    20       0
noext   3    30       0
```
### Con parametro -path
#### Input
```powershell
.\VolumeAnalizer.ps1 -path "C:\Users\stefano\Desktop\test>"
```
#### Output 

```powershell
Folders:  4
Files:  10


Name  Qty Qty_% Size_KB
----  --- ----- -------
.lnk    1    10    0.86
.txt    4    40       0
.html   2    20       0
noext   3    30       0
```
### Con i parametri -filterType e -filter 
#### Input
```powershell
.\VolumeAnalizer.ps1 -filterType 'E' -filter .txt .html
```
#### Output 

```powershell
Folders:  4
Files:  4


Name  Qty Qty_% Size_KB
----  --- ----- -------
.lnk    1    25    0.86
noext   3    75       0
```
#### Input
```powershell
.\VolumeAnalizer.ps1 -filterType 'I' -filter .txt .html
```
#### Output 

```powershell
Folders:  4
Files:  6


Name  Qty Qty_% Size_KB
----  --- ----- -------
.txt    4 66.67       0
.html   2 33.33       0
```
### Con tutti i parametri

#### Input
```powershell
.\VolumeAnalizer.ps1 -path "C:\Users\stefano\Desktop\test" -filterType E -filter .txt,.html
```
#### Output 

```powershell
Folders:  4
Files:  6


Name  Qty Qty_% Size_KB
----  --- ----- -------
.txt    4 66.67       0
.html   2 33.33       0
```

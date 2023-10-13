# logica_entrata_merce

Una Applicazione Flutter per gestire le entrate di magazzino.

## Getting Started

Questa applicazione è stata pensata per i PDA Android dei magazzini. Essa gestisce le entrate dei pallet quando un Automezzo scarica in magazzino la propria merce. 
Ogni pallet è identificato con un numero UDC che viene stampata su un'etichetta adesiva e incollata al pallet. Questo UDC deve essere considerato univoco per un determinato pallet.
Il magazziniere stampa le etichette e le attacca ai pallet nella baia di scarico dopo di ché procede alla catalogazione dei pallet mediante l'applicazione.
Il primo Screenshot dell'applicazione si presenta così

<img src="./assets/screenshot/Screenshot_1697184937.png" alt="Login Page" style="width: 400px;" />

Per entrare usare le seguenti credenziali:

* username: **Test.User**
* password: **user.test**

Se il login va a buon fine l'applicazione riceve un token JWT che utilizzerà per tutte le successive chiamate.

La schermata successiva riguarda la scelta del magazzino.

<img src="./assets/screenshot/Screenshot_1697185284.png"  alt="Pagina Magazzino" style="width: 400px;" />

La successiva scermata riguarda la scelta del cliente

<img src="./assets/screenshot/Screenshot_1697185307.png"  alt="Pagina Cliente" style="width: 400px;" />

premendo ok si prosegue alla schermata successiva per inserire la targa del automezzo che ha portato la merce

<img src="./assets/screenshot/Screenshot_1697185330.png"  alt="Automezzo" style="width: 400px;" />

dopo di che si inserisce il codice del pallet ovvero l'UDC (unità di Carico)

<img src="./assets/screenshot/Screenshot_1697185345.png"  alt="UDC Page" style="width: 400px;" />

La schermata successiva riguarda il barcode EAN 13 o altro dell'articolo

<img src="./assets/screenshot/Screenshot_1697185371.png"  alt="Articolo" style="width: 400px;" />

e successivamente viene chiesto in numero di pezzi di quell'articolo stoccato sul pallet.

<img src="./assets/screenshot/Screenshot_1697185389.png"  alt="Numero pezzi" style="width: 400px;" />

Il pallet deve essere posizionato e quindi deve essere inserita la posizione all'interno del magazzino

<img src="./assets/screenshot/Screenshot_1697185399.png"  alt="Posizionamento Pallet" style="width: 400px;" />

In quest'ultima schermata è possibile inserire un nuovo UDC oppure si va al riepilogo dati prima di salvare tutto nel database.
La schermata di riepilogo è la seguente.

<img src="./assets/screenshot/Screenshot_1697185410.png"  alt="Riepilogo dati" style="width: 400px;" />

In questa schermata è possibile cancellare un record inserito oppure fare l'edit del numero pezzi inserito.

Cancella record:
<img src="./assets/screenshot/Screenshot_1697185413.png"  alt="Delete Riepilogo dati" style="width: 400px;" />

Edit record:
<img src="./assets/screenshot/Screenshot_1697185416.png"  alt="Edit Riepilogo dati" style="width: 400px;" />

Infine se si clicca sul pulsante "INVIA DATI" i record vengono salvati nel database.

<img src="./assets/screenshot/Screenshot_1697185451.png"  alt="Edit Riepilogo dati" style="width: 400px;" />

## Alcune considerazioni sulle dipendenze usate

In questa applicazione sono state usate le dipendenze 

GetX per il Routing:

https://pub.dev/packages/get

e Get_Storage per conservare i dati globali durante la raccolta dei dati:

https://pub.dev/packages/get_storage

Per realizzare questa applicazione e soprattutto per utilizzare GetX ho seguito un tutorial su YouTube:

<a href="https://youtu.be/rI7bwmMOuXE?si=OkSaRHN4R2PalTHw" target="_blank" ><img src="./assets/screenshot/Screenshot 2023-10-13 125012.png"   alt="CodeX" style="width: 800px;" /></a>

[![https://youtu.be/rI7bwmMOuXE?si=OkSaRHN4R2PalTHw]](<img src="./assets/screenshot/Screenshot 2023-10-13 125012.png"   alt="CodeX" style="width: 800px;" />)


Link al canale CodeX [youtu.be/rI7bwmMOuXE?si=OkSaRHN4R2PalTHw](https://youtu.be/rI7bwmMOuXE?si=OkSaRHN4R2PalTHw)





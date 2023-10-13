# logica_entrata_merce

Una Applicazione Flutter per gestire le entrate di magazzino.

## Getting Started

Questa applicazione è stata pensata per i PDA Android dei magazzini. Essa gestisce le entrate dei pallet quando un Automezzo scarica in magazzino la propria merce. 
Ogni pallet è identificato con un numero UDC che viene stampata su un'etichetta adesiva e incollata al pallet. Questo UDC deve essere considerato univoco per un determinato pallet.
Il magazziniere stampa le etichette e le attacca ai pallet nella baia di scarico dopo di ché procede alla catalogazione dei pallet mediante l'applicazione.
Il primo Screenshot dell'applicazione si presenta così

<img src="./assets/screenshot/Screenshot_1697184937.png" alt="Login Page" style="width: 400px;" />

Per entrare usare le seguenti credenziali:

## username ##: Test.User
password: user.test

Se il login va a buon fine l'applicazione riceve un token JWT che utilizzerà per tutte le successive chiamate.

La schermata successiva riguarda la scelta del magazzino.

<img src="./assets/screenshot/Screenshot_1697185284.png"  alt="Pagina Magazzino" style="width: 400px;" />


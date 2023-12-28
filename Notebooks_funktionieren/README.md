## Clustering1:
Primitives unsupervised Clustering für Ausschnitt neuer Ostfriedhof -> wie weit kommt man damit und welche Clustergröße?

## classification_Augsburg_Sentinel:
Abwandlung von Patrick Grays Notebook zu Küstenbeispiel auf Augsburg
* Input: **Sentinel 2** Szene aus dem Kurs
* **Composite** der Bänder
* Input Trainingsdaten: 40 händisch im GIS erzeugte Polygone zu 10 Klassen (manuell festgelegt)
* **Trainingsdaten** generiert aus Shapefile
* Übersicht der **Intensität** der Features in den einzelnen Bändern (später wichtig für finetuning)
* Training des Classifiers mit **GaussianNB**
* Für die Sentinel Szene predicted
  * **Wichtig**: hier nur Ausschnitt: img = src.read()[:, 150:600, 250:1400], sonst crash, alle Bänder mit einbezogen
* **Ergebnisse**: zuvor festgelegte Klassen sind Schrott, wegen Playgrounds (hab blöderweise so Fußballplätze als Spielplatz klassifiziert,
  sehen viiieel zu ähnlich aus zu Häusern mit Innenhof, darum ist Augsburg jetzt fast ein einziger Spielplatz)
* Zusätzlich **NDWI** und **NDVI**
* **TODO**: bessere Trainingsdaten und Klassen -> wichtig für **Ontologie**

## classification_landcover:
Erweiterung des classification_Augsburg_Sentinel Notebooks
* Input: **Sentinel 2** Szene aus dem Kurs
* **Composite** der Bänder
* Input Trainingsdaten: [Urban Atlas Land Cover für Augsburg](https://land.copernicus.eu/en/products/urban-atlas/urban-atlas-2018)
* **Trainingsdaten** generiert aus Shapefile, hierbei **wichtig**: Clippen auf Imagery Szene, Trainingsdaten dürfen nicht außerhalb sein
  Pro Klasse nur 10 Features, sonst too much, Rausschmeißen der Features, die kein komplettes Pixel Set haben und außerhalb liegen
* Übersicht der **Intensität** der Features in den einzelnen Bändern (später wichtig für finetuning)
* Training des Classifiers mit **GaussianNB**
* Für die Sentinel Szene predicted
  * **Wichtig**: hier nur Ausschnitt: Ausschnitt angepasst auf Stadtgebiet, sonst crash, alle Bänder mit einbezogen
* **Ergebnisse**: alle Landcover Klassen zu nutzen wäre für uns Schrott, Ergebniss: fast alles Flughafen oder Schienen
* * **TODO**: entschieden welche Klassen behalten werden sollen und in welchem Gewicht -> wichtig für **Ontologie**
* Prediction auch für **RandomForest**
* Prediction auch für **KMeans**
* Prediction auch für **Kneighbors**
* Prediction auch für **DecisionTree**

## models:
Zur Veranschaulichung, wie sich unterschiedliche Modelle bei Punkten oder Polygonen verhalten, muss noch angepasst werden, was die Daten betrifft <br>
Aktueller Input:
* Punkte: von Irada
* Polygone: 40 Input Polygone für Augsburg

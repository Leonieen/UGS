![image](https://github.com/Leonieen/UGS/assets/48885814/f9dcc770-3a02-4722-aad1-2f44e22de53a)


## Clustering1:
Link: [Clustering1.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/Clustering1.ipynb) <br>
Primitives unsupervised Clustering für Ausschnitt neuer Ostfriedhof -> **TODO**: wie weit kommt man damit und welche Clustergröße?

## classification_Augsburg_Sentinel:
Link: [classification_Augsburg_Sentinel.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_Augsburg_Sentinel.ipynb) <br>
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
Link: [classification_landcover.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_landcover.ipynb) <br>
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
Link: [models.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/models.ipynb) <br>
Zur Veranschaulichung, wie sich unterschiedliche Modelle bei Punkten oder Polygonen verhalten, muss noch angepasst werden, was die Daten betrifft <br>
Aktueller Input:
* Punkte: von Irada
* Polygone: 40 Input Polygone für Augsburg
* **TODO**: Anpassen für wirklich verwendete Daten

## Trainingsdaten generieren:
Auf Orthofotoebene: Bilder und Trainingsdaten via GeoSAM <br>
* Für größere Features wie Wege, Gebäude oder Bäume: [input_prompts.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/input_prompts.ipynb)
 * Festlegen, was Festure ist (Vordergrund) und als Hintergrund angrenzende Gebiete markieren
 * Anschließend als Vektor exportieren
* Für kleinere Features, wie Grabsteine, Bänke, etc: [box_prompts.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/box_prompts.ipynb)
 * Feature mittels BBox markieren
 * Anschließend als Vektore exportieren
* Am Ende alle exportierten Vektor Features zu einem Datensatz mit entsprechenden Klassen zusammenfügen
* Modelle aus z.B. classification_landcover.ipynb können dann mit den Fotos und Daten traininert werden

## Trainingsdaten OSM:
Aus OSM Daten Trainingsdaten generieren und exportieren <br>
Link: [trainingsdata_osm.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/trainingsdata_osm.ipynb)
Sinnvolle Kategorien:
* leisure: park
* leisure; playground
* amenity: funeral_hall
* amenity: bench
* highway: footway
* historic: memorial
* landuse: s´cemetery
* landuse: grass
* landuse: recreation_ground
* building: True
* Zusammenfassen aller Kategorien, Spalte für Klasse und exportieren
* Alles als Polygone
* **TODO**: bench und footway Buffer und als Polygon, aktuell noch nicht in Trainingsdaten

## Klassifizieren Sentinel OSM:
Verschiedene Modelle aus Sentinel 2 Szene angewandt mit den exportiereten OSM Daten als Trainingsdaten <br>
Link: [classification_landcover_osm.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_landcover_osm.ipynb)

## Klassifizieren Ortho OSM:
Raster durch GeoSAM exportiert und OSM als Trainingsdaten
Link: [classification_landcover_ortho.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_landcover_ortho.ipynb)
funktioniert, aber durchaus sehr Zeitintensiv

## Update nach Meeting 10.01.2024:
Nur Klassen Grün nicht Grün <br>
Link: [classification_OnlyGreens.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_OnlyGreens.ipynb) <br>
Klassen Grün nicht Grün + Buildings <br>
Link: [classification_OnlyGreensBuildings.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/classification_OnlyGreensBuildings.ipynb) <br>

## Update 24.01.2024: XGBoost
Link: [raster_classification.ipynb](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/raster_classification.ipynb) <br>
Zusätzlich auch Validation data und Boosting -> große Verbesserung für NotGreen, Green und Buildings

## Level 1 28.01.2024:
![image](https://github.com/Leonieen/UGS/assets/48885814/c2be2b8a-096b-433a-8204-ee435c9a53a6)

## Level 2 28.01.2024:
Link: [level_2_classification_cemetery.ipyn](https://github.com/Leonieen/UGS/blob/main/Notebooks_funktionieren/level_2_classification_cemetery.ipynb)
![image](https://github.com/Leonieen/UGS/assets/48885814/11c3f39c-335f-43e2-8c44-813fb5be1858)

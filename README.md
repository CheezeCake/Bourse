Application de surveillance de flux boursiers
ALONSO JIMENEZ Julien & NICOLET Emmanuel

Organisation:
- data : Dossier de stockage des données
- graphs : Dossier de stockage des graphes
- save : Dossier de stockage des sauvegardes
- scripts :
  - start.sh : Script de lancement de l'application
  - stop.sh : Script de fermeture de l'application
  - save.sh : Script de sauvegarde (en archives)
  - fetchdata.sh : Script d'automatisation du relevé de cours des actions
  - alert.sh : Script gérant les avertissement en cas de baisse du cours d'une action
  - gengraph.sh : Script de génération du graphe pour chaque action surveillée
  - getprice.sh : Script de récupération du cours de l'action
  - plotscript.sh : Script de génération d'un graphe avec gnuplot
- tmp : Dossier utilisé pour les fichiers temporaires
- actions : Fichier contenant les flux surveillés
- bourse : Script principal de l'application
- config : Fichier de configuration des intervalles de temps et autres paramètres

Utilisation:
1 - Entrer les paramètres d'intervalle de temps, de sauvegarde et de valeur critique pour les alertes dans le fichier "config" en suivant les instructions contenues dans ce même fichier(si aucun paramètre n'est entré les paramètres par défaut seront actifs).
2 - Entrer les actions suivies dans le fichier "actions"
3 - Executer bourse start

Commandes :
bourse start : Lancement de l'application
bourse stop : Fermeture de l'application
bourse restart : Relancement de l'application
bourse help : Affichage de l'aide
bourse status : ????
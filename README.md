# UserAppDemo

L'application est composée de 3 ViewController
 - MasterViewController: affiche la liste des utilisateurs
 - AlbumsViewController: affiche la liste des albums d'un utilisateur
 - PhotoCollectionViewController: affiche une galerie des photos d'un album
 
Les utilisateurs, albums et photos sont représentés par des classes 

L'application dispose d'un store gérant les requêtes. Les requêtes sont parsées puis retournées sous forme de tableaux d'objets via des listeners

Pour cette application, je n'ai pas utilisé d'API autres que celles fournies par Apple:
 - URLSession pour les requêtes
 - JSONSerialization pour le parsing
  
Je préfère le plus possible utiliser les classes fournies par Apple pour éviter de tomber sur des problèmes de compatibilité de version de Swift.
 
Je n'ai pas terminé la galerie de photos. La liste des photos contenues dans l'album est chargée mais il me manque le téléchargement et l'affichage.
Il m'aurait fallu environ 15-20 minutes pour le terminer.
 
Pour passer sur Android, on peut garder à peu près la même structure:
 - on remplace les ViewController par des activity
 - le model reste inchangé
 - pour le store, il faut utiliser une API comme Volley ou Robospice pour gérer correctement les requètes et les synchroniser avec le cycle de vie des activity
 - les interfaces de chargement et les listener peuvent rester identique
  
  
  Difficultés:
  De manière générale, il n'y a pas de grosses difficultés. Il faudrait plus de temps pour avoir un design plus propre.
  Je ne suis pas non plus entièrement satisfait de mon modèle. On aurait pu, à partir de la liste des utilisateurs, appeler par exemple une méthode user.loadAlbums() et ne pas passer le store entre ViewController directement. A voir...
  

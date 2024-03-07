#Les commandes

B 					-> Commencer à construire (créer des unités pour l'instant,
						pour les tests, on a pas encore de bâtiment mdr)
clic gauche 		-> dé-selectionner tout + selectionner ce sur quoi on clic
ctrl+clic gauche 	-> ajouter ce sur quoi on clic à la selection
clic droit 			-> Bouger et attaquer à vue à la position selectionné

X 					-> Déselectionne tout, d'ici que je réfléchissse à un
						moyen d'implémenter bien le clic_g/ctrl+clic_g
---
Faudra mettre une sécurité qqpart pour que les clics sur l'HUD ne déclanche pas
ces commandes, mais on verra quand on commencera à faire un HUD

---
# Selection
##Je pense que la sélection doit se faire par une mécanique de signal
Quand une unité apparait elle se connecte au signal ordre global, en plus de 
gérer les ordres de types "tout le monde attaque ici" il permettra d'envoyer un 
signal type 'unité 2 est sélectionnée", on peut ainsi choisir lorsqu'on effectue
un clic gauche sur une unité de d'abord émettre le signal global de déselection,
puis le signal qui indique qui est selectionné, ça permet une implémentation
safe du clic_g / ctrl+clic_g

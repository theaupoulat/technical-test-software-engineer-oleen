# Test technique - Dévelopeur fullstack Oleen

## Rendu

Dans le dossier algo, vous trouverez le fichier `calendlo.rb` qui implémente la classe Calendlo, permettant de donner une liste de disponibilités, selon un set de contraintes.

Dans le dossier front, vous trouverez l'implémentation du front base sur la maquette Figma, qui se lance en suivant les instructions du README du sous-dossier.

Pour générer un set de données pour le front, vous pouvez utiliser le fichier `success_test.rb`. Vous pouvez modifier les contraintes et imprimer le résultat dans la console. Ensuite, copy-paste dans la variable dataSampleHard dans le fichier src/utils/format du front.

## Objectif

L'objectif de ce test technique est d'évaluer

- ta capacité à résoudre des problèmes
- tes compétences en programmation et algorithmique
- tes compétences en front-end
- ta créativité

## Sujet

Au cours de l'expérience Pretto, un client va régulièrement prendre contact avec son conseiller. Pour cela, il doit prendre rendez-vous sur son espace client via une interface similaire à [celle ci](https://www.figma.com/file/C5tgby7R14aoUoTU4yy2Ic/Test-Technique?type=design&node-id=0-1&t=TArsrLIVvCLEKnSX-0).

Cette grille est généré à partir de plusieurs points de données:

- La liste d’évènements prévu dans son calendrier.

  _Exemple_

  ```yaml
  - name: "RDV #1"
    start: 2020-02-01T08:00:00Z
    end: 2020-02-01T08:30:00Z
  - name: "RDV #2"
    start: 2020-02-01T08:45:00Z
    end: 2020-02-01T09:15:00Z
  ```

- Les horaires de travail du conseiller. Il s'agit des plages horaires sur lesquels le conseiller est joignable (ou non)

  ```yaml
  - allowDayAndTime: # horaires de travail
      # day est compris dans [1..7]
      # start/end : [00:00 .. 23:59]
      - day: 1 # lundi
        start: "08:00"
        end: "12:00"
      - day: 1 # lundi
        start: "13:00"
        end: "17:30"
      - day: 2 # mardi
        start: "08:30"
        end: "13:00"
      - day: 2 # mardi
        start: "14:00"
        end: "18:00"
      - ...
  - blockSlot: # vacances
      - start: 2020-07-01
        end: 2020-07-07
      - ...
  - allowSlot: # permanences du samedi
      - start: "2021-03-06T08:00:00Z"
        end: "2021-03-06T16:00:00Z"
  ```

- Les contraintes du rendez vous :
  - La durée. Elle varie avec l'avancement du client dans le parcours. Certains durent **30 minutes**, d'autres **15 minutes.**
  - La durée du temps de préparation. Il est nécessaire de réserver quelques minutes de battement pour permettre au conseiller de relire la fiche client. Juste avant le rendez-vous, il faut réserver **5 ou 15 minutes en amont** selon le type de rendez-vous.
  - L’heure de départ. Les rendez-vous commencent **toujours à pile, et-quart, et-demi et moins-le-quart.**

## Exercice - Partie 1

Créer un programme permettant de calculer les disponibilités d'un expert.

1. Vous pouvez utiliser le langage de programmation de votre choix.
2. N'hésitez pas à laisser des commentaires, écrire des tests unitaires et laisser un minimum de documentation pour lancer votre programme.
3. Ne restez pas bloqué à cause d'une contrainte qui vous pose problème, soyez libre d'ignorer une difficulté pour avancer. Mieux vaut une solution partielle qui fonctionne bien qu'une solution complète qui fonctionne mal. J’ai volontairement omis l'attendu de chaque jeux de tests parce que ça fait aussi parti du job de déterminer comment le service va fonctionner.

[Jeux de tests faciles ](./easy_test_case.md)

[Jeux de test moins faciles](./medium_test_case.md)

[Jeux de test encore moins facile](./hard_test_case.md)

## Exercice - Partie 2

Créer une application frontend en utilisant React qui reproduit le Figma ce dessous

https://www.figma.com/file/C5tgby7R14aoUoTU4yy2Ic/Test-Technique?type=design&node-id=0-1&t=TArsrLIVvCLEKnSX-0

Bonus: Créer une application backend avec l’algorithme de la partie précédente et faire communiquer les 2 applications

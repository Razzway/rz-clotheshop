## Description
**rz-clotheshop** est un magasin de vêtement développée en RageUI sur le Framework ESX.

## Important
- **Vous n'êtes pas autorisé à modifier le nom de la ressource**
- **Vous n'êtes pas autorisé à modifier la ressource et à la republier, vous ne pouvez que la fork**

## Preview
- Vidéo présentation : https://streamable.com/vyb54o

## Features
- Optimisation 0.00ms (Hors utilisation)
- Enregistrement de tenue dans le dressing
- Possibilité d'équiper, de renommer ou de supprimer une tenue
- Acheter des tenues pré faites (avec les composants définis dans un fichier) est désormais possible (activable ou non) + le prix de ces tenues changent automatiquement à chaque reboot, ils sont compris entre 100 et 250$ (configurable) 
- Message aléatoire de la vendeuse lors d'un nouvel achat de tenue ou accessoire parmi une liste définie au préalable (vous pouvez en rajouter)
- Compatible mysql-async & oxmysql
- Compatible base ESX & California
- Système avancé de caméra + possibilité de tourner le personnage pour simplicité la visualisation du rendu
- Possibilité de choisir le numéro du composant (touche ENTER sur le bouton)
en gros si vous êtes sur la liste des t-shirt et que vous voulez le 119 par exemple, bah vous appuyez sur la touche "enter", vous indiquez 119 et ça vous mettra au t-shirt 119
- Petite animation lorsque le personnage se change
- Events sécurisés face aux moddeurs 
- Logs discord & console ultra complète pour suivre les actions des joueurs (id in game, id discord, date + heure précise...)
- Configuration simple, complète et facile d'utilisation (vous pouvez quasiment tout gérer depuis là-bas)
- Plusieurs points dans les magasins, chacun spécifique (lunettes, casques, montres, chaines...)

## Requirements
- [es_extended](https://github.com/esx-framework/esx-legacy/tree/main/%5Besx%5D/es_extended)
- Si vous rencontrez des problèmes d'invisibilité du personnage, installez ce skinchanger (à noter que cette ressource contient également l'esx_skin, c'est un compactage, celui de california mais adapté pour legacy. Vous devrez donc start uniquement cette ressource)
- [esx_skin](https://github.com/esx-framework/esx-legacy/tree/main/%5Besx%5D/esx_skin)
- [skinchanger](https://github.com/esx-framework/esx-legacy/tree/main/%5Besx%5D/skinchanger)

## If you need help
- **Discord** : Razzway#0871 & [Razzway FiveM Store](https://discord.gg/EtWdxsCv94)

## Installation
- Configure your `server.cfg` to look like this

```
ensure rz-clotheshop
```
## License
rz-clotheshop - work on ESX Framework

Copyright (C) 2022 Razzway.

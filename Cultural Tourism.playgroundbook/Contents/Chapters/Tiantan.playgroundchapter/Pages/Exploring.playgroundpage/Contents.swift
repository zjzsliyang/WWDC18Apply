//#-hidden-code

// Contents.swift
// Created by Yang Li on 31/03/2018.
//
// Copyright © 2018 Yang Li, Tongji University, Shanghai.
// All rights reserved.
//

import UIKit
import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func explore() {
  proxy?.send(PlaygroundValue.string("explore"))
}

// func randomMeetPokemon() {
//   proxy?.send(PlaygroundValue.string("randomMeetPokemon"))
// }

// func catchIt() {
//   proxy?.send(PlaygroundValue.boolean(true))
// }

//#-end-hidden-code
/*:
 After our rocket was launched🤗, let's catch our first ❤️Pokémon!
 
 Though there have three Poké Balls, but **ONLY the fastest one** can catch a Pokémon.
 
 And you can also randomly meet other Pokémon.
 
 * callout(randomly meet the Pokémon):
 `randomMeetPokemon()`
 
 Which Pokémon will choose you?
 
 Think about it and experiment now!
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, randomMeetPokemon())

// Try to run it!

// catchIt()
// And then meet one randomly before catch it.
// CAUTION: random function will work when you press stop.
/*:
 Why have you always gotten the second one? Why even a straight line is the slowest?

 This is a famous problem called [Brachistochrone Problem](glossary://Brachistochrone%20Problem) posed by [Johann Bernoulli](glossary://Johann%20Bernoulli) in June 1696.

 [Galileo](glossary://Galileo) in 1638 had studied the problem in his famous work(Discourse on two new sciences). He think that the path of quickest descent from A to B would be an arc of a circle.

 At the end, five mathematicians responded with solutions via [calculus of variations](glossary://calculus%20of%20variations) or [Snell's law](glossary://Snell's%20law): [Newton](glossary://Newton), Jakob Bernoulli (Johann's brother), [Gottfried Leibniz](glossary://Gottfried%20Leibniz), [Ehrenfried Walther von Tschirnhaus](glossary://Ehrenfried%20Walther%20von%20Tschirnhaus) and [Guillaume de l'Hôpital](glossary://Guillaume%20de%20l'Hopital).
*/

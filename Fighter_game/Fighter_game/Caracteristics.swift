//
//  CAracteristics.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 19/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

class Caracteristic{
  let name: String
  var value: Int
  
  init(name:String, value: Int){
    self.name = name
    self.value = value
  }
}

class Force:Caracteristic{
  init(){
    super.init(name:"force", value:0)
    
  }
}

class Agility:Caracteristic{
  init(){
    super.init(name:"agilité", value:0)
    
  }
}

class Intelligence:Caracteristic{
  init(){
    super.init(name:"intelligence", value:0)
    
  }
}

class Wizardry:Caracteristic{
  init(){
    super.init(name:"sorcellerie", value:0)}
}

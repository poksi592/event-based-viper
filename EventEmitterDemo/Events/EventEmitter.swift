//
//  EventEmitter.swift
//  EventEmitterDemo
//
//  Created by Mladen Despotovic on 13.08.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation

/**
 This protocol should be adopted by any object which wants to emit or receive the events
 */
public protocol EventEmitting {
    
    associatedtype EventEmitter: EventEmitterType
    var eventEmitter: EventEmitter? { get set }
}

/**
 This protocol is to be adopted by any class which is used to broadcasting the events.
 They don't know about their listeners, which simply subscribe to `EventEmitterProtocol` objects
 */
public protocol EventEmitterType: class {
    
    typealias EventCallbackClosure = ([String: Any]) -> Void

    /**
     Function adds subscriber's callback to
     - parameters:
     - listener: returns the `[AnyHashable: Any]` dictionary that contains all kinds of parameters which are convention for each particular
     */
    func subscribe(_ listener: @escaping EventCallbackClosure)
    
    /**
     Deletes all subscribers
     */
    func unsubscribeAll()
    
    /**
     Contains collection of all subscriber's callback closures
     */
    var callbacks: [EventCallbackClosure] { get set }
    
    /**
     Queue used for notifying
     */
    var serialQueue: DispatchQueue { get set }
    
    /**
     Function which notifies all the "closures" with the passed payload
     */
    func notify(eventPayload: [String: Any])
}

extension EventEmitterType {
    
    func subscribe(_ listener: @escaping EventCallbackClosure) {
        
        callbacks.append(listener)
    }
    
    func unsubscribeAll() {
        
        callbacks.removeAll()
    }
    
    func notify(eventPayload: [String: Any]) {
        
        serialQueue.sync {
            
            callbacks.forEach { $0(eventPayload) }
        }
    }
}

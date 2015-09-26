//
//  twoD-math.swift
//  swix
//
//  Created by Scott Sievert on 7/10/14.
//  Copyright (c) 2014 com.scott. All rights reserved.
//

import Foundation
import Accelerate

func apply_function(function: ndarray->ndarray, x: matrix)->matrix{
    let y = function(x.flat)
    var z = zeros_like(x)
    z.flat = y
    return z
}

// TRIG
public func sin(x: matrix) -> matrix{
    return apply_function(sin, x: x)
}
public func cos(x: matrix) -> matrix{
    return apply_function(cos, x: x)
}
public func tan(x: matrix) -> matrix{
    return apply_function(tan, x: x)
}
public func tanh(x: matrix) -> matrix {
    return apply_function(tanh, x: x)
}

// BASIC INFO
public func abs(x: matrix) -> matrix{
    return apply_function(abs, x: x)
}
public func sign(x: matrix) -> matrix{
    return apply_function(sign, x: x)
}

// POWER FUNCTION
public func pow(x: matrix, power: Double) -> matrix{
    let y = pow(x.flat, power: power)
    var z = zeros_like(x)
    z.flat = y
    return z
}
public func sqrt(x: matrix) -> matrix{
    return apply_function(sqrt, x: x)
}

// ROUND
public func floor(x: matrix) -> matrix{
    return apply_function(floor, x: x)
}
public func ceil(x: matrix) -> matrix{
    return apply_function(ceil, x: x)
}
public func round(x: matrix) -> matrix{
    return apply_function(round, x: x)
}

// LOG
public func log(x: matrix) -> matrix{
    return apply_function(log, x: x)
}

// BASIC STATS
public func min(x:matrix, y:matrix)->matrix{
    var z = zeros_like(x)
    z.flat = min(x.flat, y: y.flat)
    return z
}
public func max(x:matrix, y:matrix)->matrix{
    var z = zeros_like(x)
    z.flat = max(x.flat, y: y.flat)
    return z
}


// AXIS
public func sum(x: matrix, axis:Int = -1) -> ndarray{
    // arg dim: indicating what dimension you want to sum over. For example, if dim==0, then it'll sum over dimension 0 -- it will add all the numbers in the 0th dimension, x[0..<x.shape.0, i]
    assert(axis==0 || axis==1, "if you want to sum over the entire matrix, call `sum(x.flat)`.")
    if axis==1{
        let n = x.shape.1
        let m = ones((n,1))
        return (x.dot(m)).flat
    }
    else if axis==0 {
        let n = x.shape.0
        let m = ones((1,n))
        return (m.dot(x)).flat
    }
    
    // the program will never get below this line
    assert(false)
    return zeros(1)
}
public func prod(x: matrix, axis:Int = -1) -> ndarray{
    assert(axis==0 || axis==1, "if you want to sum over the entire matrix, call `sum(x.flat)`.")
    let y = log(x)
    let z = sum(y, axis:axis)
    return exp(z)
}
public func mean(x:matrix, axis:Int = -1) -> ndarray{
    assert(axis==0 || axis==1, "If you want to find the average of the whole matrix call `mean(x.flat)`")
    let div = axis==0 ? x.shape.0 : x.shape.1
    return sum(x, axis:axis) / div.double
}

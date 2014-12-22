import UIKit
import Genetics
import XCPlayground

let size = CGSizeMake(200, 200)

let a = DNA()
let fitnessCalculator = FitnessCalculator()

let image = a.drawWithSize(size, scale: 1)

let view = UIImageView(image: image)
view.frame = CGRectMake(0, 0, size.width, size.height)

XCPShowView("image", view)

let fitness = fitnessCalculator.fitnessBetweenImages(image, image)
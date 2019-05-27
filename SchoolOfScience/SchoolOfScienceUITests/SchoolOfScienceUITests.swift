//
//  SchoolOfScienceUITests.swift
//  SchoolOfScienceUITests
//
//  Created by Jacky Tang on 27/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import XCTest

class SchoolOfScienceUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {

        XCUIApplication().launch()

    }

    func test_Login() {


        if(app.tabBars.buttons["Settings"].exists) {
            waitForElementToBeHitable(app.tabBars.buttons["Settings"])
            app.tabBars.buttons["Settings"].tap()
            app.buttons["Logout"].tap()
            app.alerts["Are you sure to logout Jacky Tang ?"].buttons["YES"].tap()
        }

        app.textFields["your RMIT email"].tap()
        app.textFields["your RMIT email"].clearText()
        app.textFields["your RMIT email"].typeText("s3598284@student.rmit.edu.au")
        app.dismissKeyboard()

        app.secureTextFields["your password"].tap()
        app.secureTextFields["your password"].clearText()
        app.secureTextFields["your password"].typeText("t4908866")
        app.dismissKeyboard()

        app.buttons["Login"].tap()
        waitForElementToAppear(app.tabBars.buttons["News"])

        XCTAssert(app.tabBars.buttons["Events"].exists)

    }

    func test_Logout() {

        if(app.textFields["your RMIT email"].exists) {
            app.textFields["your RMIT email"].tap()
            app.textFields["your RMIT email"].clearText()
            app.textFields["your RMIT email"].typeText("s3598284@student.rmit.edu.au")
            app.dismissKeyboard()

            app.secureTextFields["your password"].tap()
            app.secureTextFields["your password"].clearText()
            app.secureTextFields["your password"].typeText("t4908866")
            app.dismissKeyboard()

            app.buttons["Login"].tap()
            waitForElementToAppear(app.tabBars.buttons["News"])
        }

        waitForElementToBeHitable(app.tabBars.buttons["Settings"])
        app.tabBars.buttons["Settings"].tap()
        app.buttons["Logout"].tap()
        app.alerts["Are you sure to logout Jacky Tang ?"].buttons["YES"].tap()

    }

    func test_CreateAccount() {

        test_Logout()

        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()

        app.textFields["your RMIT email"].tap()
        app.textFields["your RMIT email"].clearText()
        app.textFields["your RMIT email"].typeText("s3598284@student.rmit.edu.au")
        app.dismissKeyboard()

        app.textFields["your name"].tap()
        app.textFields["your name"].clearText()
        app.textFields["your name"].typeText("Jacky")
        app.dismissKeyboard()

        app.secureTextFields["your password"].tap()
        app.secureTextFields["your password"].clearText()
        app.secureTextFields["your password"].typeText("t4908866")
        app.dismissKeyboard()

        app.secureTextFields["confirm your password"].tap()
        app.secureTextFields["confirm your password"].clearText()
        app.secureTextFields["confirm your password"].typeText("t4908866")
        app.dismissKeyboard()

        signUpButton.tap()
        waitForElementToAppear(app.alerts["The email address is already in use by another account."])
        app.alerts["The email address is already in use by another account."].buttons["OK"].tap()
        app.buttons["Cancel"].tap()

    }

    func test_ForgetPassword() {
        test_Login()

        waitForElementToBeHitable(app.tabBars.buttons["Settings"])
        app.tabBars.buttons["Settings"].tap()

        app.buttons["Change Password"].tap()
        app.textFields["your RMIT email"].tap()
        app.textFields["your RMIT email"].clearText()
        app.textFields["your RMIT email"].typeText("s3598284@student.rmit.edu.au")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        app.buttons["Send Email"].tap()

        waitForElementToAppear(app.alerts["Reset email was sent successfully!"])
        app.alerts["Reset email was sent successfully!"].buttons["OK"].tap()

    }

    func test_News() {
        test_Login()

        waitForElementToBeHitable(app.tabBars.buttons["News"])
        app.tabBars.buttons["News"].tap()

        XCTAssert(app.buttons["General"].exists)
        XCTAssert(app.buttons["Research"].exists)
        XCTAssert(app.buttons["Learning"].exists)

        app.scrollViews.otherElements.containing(.staticText, identifier:"How to go from a democracy to dictatorship in a few easy steps").element.swipeLeft()
        app.tables.staticTexts["How to go from a democracy to dictatorship in a few easy steps"].tap()
        XCTAssert(app.staticTexts["How to go from a democracy to dictatorship in a few easy steps"].exists)

        app.buttons["Back"].tap()
        waitForElementToBeHitable(app.tabBars.buttons["News"])
        XCTAssert(app.tabBars.buttons["News"].exists)

    }

    func test_Events() {
        test_Login()

        waitForElementToBeHitable(app.tabBars.buttons["Events"])
        app.tabBars.buttons["Events"].tap()

        XCTAssert(app.buttons["General"].exists)
        XCTAssert(app.buttons["Research"].exists)
        XCTAssert(app.buttons["Learning"].exists)

        app.scrollViews.otherElements.containing(.staticText, identifier:"TTTT").element.swipeLeft()
        app.tables.staticTexts["TTTT"].tap()
        XCTAssert(app.staticTexts["TTTT"].exists)

        app.buttons["Back"].tap()
        waitForElementToBeHitable(app.tabBars.buttons["Events"])
        XCTAssert(app.tabBars.buttons["Events"].exists)

    }

    func test_Settings() {
        test_Login()

        waitForElementToBeHitable(app.tabBars.buttons["Settings"])
        app.tabBars.buttons["Settings"].tap()

        XCTAssert(app.staticTexts["Jacky Tang"].exists)
        XCTAssert(app.staticTexts["s3598284@student.rmit.edu.au"].exists)

    }

    func test_Deadlines() {
        test_Login()

        waitForElementToBeHitable(app.buttons["timer red"])
        app.buttons["timer red"].tap()
        XCTAssert(app.staticTexts["Deadlines"].exists)

        app.buttons["Back"].tap()
        XCTAssert(!app.staticTexts["Deadlines"].exists)

    }

    func test_Contacts() {
        test_Login()

        waitForElementToBeHitable(app.tabBars.buttons["Settings"])
        app.tabBars.buttons["Settings"].tap()

        app.buttons["Contacts"].tap()
        waitForElementToBeHitable(app.searchFields["Search"])
        app.searchFields["Search"].tap()
        app.searchFields["Search"].clearText()
        app.searchFields["Search"].typeText("How to")
        app.dismissKeyboard()
        app.dismissKeyboard()
        XCTAssert(app.tables.staticTexts["How to get in touch with RMIT."].exists)

    }

}

extension XCUIApplication {
    public func dismissKeyboard() {
        // If the hardware keyboard connected, only the keyboard’s top bar will display
        if self.keyboards.otherElements["Top bar"].buttons["Dismiss"].exists {
            self.keyboards.buttons["Dismiss"].tap()
        }
    }
}

extension XCTestCase {
    public func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
    }
    public func waitForElementToBeHitable(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "isHittable == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 20, handler: nil)
    }
}

extension XCUIElement {

    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }
}

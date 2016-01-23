//
//  Photo_AlbumTests.swift
//  Photo-AlbumTests
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import XCTest
@testable import Photo_Album

class Photo_AlbumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAlbumsURLConnection() {
        let URL = NSURL(string: "http://jsonplaceholder.typicode.com/albums")!
        let expectation = expectationWithDescription("Test Albums URL")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(URL) { data, response, error in
            
            XCTAssertNotNil(data, "data should not be nil")
            
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? NSHTTPURLResponse
            {
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")

            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("There is an Error")

            }
            task.cancel()
        }
    }
    
    
    
    func testPhotosURLMimeTye() {
        
        let URL = NSURL(string: "http://placehold.it/150/30ac17")!
        
        let expectation = expectationWithDescription("Test Album Photos MIME Type")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(URL) { data, response, error in
            
            XCTAssertNotNil(data, "Data should not be nil")
            
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? NSHTTPURLResponse,
                responseURL = HTTPResponse.URL,
                MIMEType = HTTPResponse.MIMEType
            {

                XCTAssertNotEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should NOT be equal to original URL, Must Be Redirected to valid Image URL")

                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                
                XCTAssertEqual(MIMEType, "image/png", "HTTP response content type should be image/png")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
}

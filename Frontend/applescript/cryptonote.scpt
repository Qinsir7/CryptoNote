-- CryptoNote Run Script
-- Processes notes and interacts with blockchain

-- Configuration
property targetFolderName : "CryptoNote"
property memoryNoteTitle : "Memory"
property newsNoteTitle : "News"
property analysisNoteTitle : "Analysis"
property tradeNoteTitle : "Trade"

-- API Configuration
property apiUrl : "http://localhost:3000/api" -- local test API
property walletKey : "test_wallet_key_12345" -- private key

-- Helper function to replace text
on replace_text(theText, searchString, replacementString)
    set AppleScript's text item delimiters to searchString
    set theTextItems to every text item of theText
    set AppleScript's text item delimiters to replacementString
    set theText to theTextItems as string
    set AppleScript's text item delimiters to ""
    return theText
end replace_text

-- Generate random string
on random_string(length)
    set chars to "abcdefghijklmnopqrstuvwxyz0123456789"
    set result to ""
    repeat length times
        set result to result & character (random number from 1 to count of chars) of chars
    end repeat
    return result
end random_string

-- Setup logging
on logMessage(message)
    set logPath to (do shell script "echo $HOME") & "/Library/Logs/CryptoNote.log"
    do shell script "echo \"$(date '+%Y-%m-%d %H:%M:%S') - " & message & "\" >> " & quoted form of logPath
end logMessage

-- Get wallet from keychain
on getWallet()
    try
        set walletInfo to do shell script "security find-generic-password -w -s " & walletKeychain
        return walletInfo
    on error
        display dialog "Wallet not found. Please run the setup script first." buttons {"OK"} default button "OK"
        return ""
    end try
end getWallet

-- Process Memory note with API
on processMemory(currentContent)
    -- Split content into paragraphs
    set paragraphList to paragraphs of currentContent
    set paragraphCount to count of paragraphList
    
    -- Create a new content string
    set newContent to ""
    set memoryProcessed to 0
    
    -- Process each paragraph
    repeat with i from 1 to paragraphCount
        -- Get current paragraph
        set currentParagraph to item i of paragraphList
        
        -- Add current paragraph to new content
        set newContent to newContent & currentParagraph
        
        -- Check if this paragraph needs processing
        if currentParagraph contains "@crypto" and not (currentParagraph contains "🔄") then
            -- Check if next paragraph is a response
            set hasResponse to false
            if i < paragraphCount then
                set nextParagraph to item (i + 1) of paragraphList
                if nextParagraph contains "🔄" then
                    set hasResponse to true
                end if
            end if
            
            -- If no response, add one
            if not hasResponse then
                -- Call API
                set apiResponse to callAPI("/memory", currentParagraph)
                
                -- Simple response parsing
                if apiResponse contains "error" then
                    set newContent to newContent & "

❌ wrong: API call failed"
                else
                    set newContent to newContent & "

🔄 Memory saved: " & apiResponse
                    
                    set memoryProcessed to memoryProcessed + 1
                end if
            end if
        end if
        
        -- Add newline if not last paragraph
        if i < paragraphCount then
            set newContent to newContent & "
"
        end if
    end repeat
    
    return {newContent, memoryProcessed}
end processMemory

-- Process News note with API
on processNews(noteContent)
    -- Similar structure to processMemory but with news API endpoint
    -- Split content into paragraphs
    set paragraphList to paragraphs of noteContent
    set paragraphCount to count of paragraphList
    
    -- Create a new content string
    set newContent to ""
    set processedCount to 0
    
    -- Process each paragraph
    repeat with i from 1 to paragraphCount
        -- Get current paragraph
        set currentParagraph to item i of paragraphList
        
        -- Add current paragraph to new content
        set newContent to newContent & currentParagraph
        
        -- Check if this paragraph needs processing
        if currentParagraph contains "@crypto" and not (currentParagraph contains "🔄") then
            -- Check if next paragraph is a response
            set hasResponse to false
            if i < paragraphCount then
                set nextParagraph to item (i + 1) of paragraphList
                if nextParagraph contains "🔄" then
                    set hasResponse to true
                end if
            end if
            
            -- If no response, add one
            if not hasResponse then
                -- Get wallet info
                set walletInfo to getWallet()
                if walletInfo is "" then
                    return noteContent
                end if
                
                -- Prepare API call
                set encodedQuery to do shell script "echo " & quoted form of currentParagraph & " | base64"
                
                set curlCmd to "curl -s -X GET " & apiBaseUrl & "/news/fetch?query=" & encodedQuery
                
                try
                    -- Call API
                    set apiResponse to do shell script curlCmd
                    
                    -- Add response
                    set newContent to newContent & "

🔄 Latest news: " & apiResponse
                    
                    logMessage("News fetched successfully")
                    set processedCount to processedCount + 1
                on error errMsg
                    -- Add error response
                    set newContent to newContent & "

❌ Error: " & errMsg
                    
                    logMessage("Error fetching news: " & errMsg)
                end try
            end if
        end if
        
        -- Add newline if not last paragraph
        if i < paragraphCount then
            set newContent to newContent & "
"
        end if
    end repeat
    
    return {newContent, processedCount}
end processNews

-- Process Analysis note with API
on processAnalysis(noteContent)
    -- Similar structure to processMemory but with analysis API endpoint
    -- Split content into paragraphs
    set paragraphList to paragraphs of noteContent
    set paragraphCount to count of paragraphList
    
    -- Create a new content string
    set newContent to ""
    set processedCount to 0
    
    -- Process each paragraph
    repeat with i from 1 to paragraphCount
        -- Get current paragraph
        set currentParagraph to item i of paragraphList
        
        -- Add current paragraph to new content
        set newContent to newContent & currentParagraph
        
        -- Check if this paragraph needs processing
        if currentParagraph contains "@crypto" and not (currentParagraph contains "🔄") then
            -- Check if next paragraph is a response
            set hasResponse to false
            if i < paragraphCount then
                set nextParagraph to item (i + 1) of paragraphList
                if nextParagraph contains "🔄" then
                    set hasResponse to true
                end if
            end if
            
            -- If no response, add one
            if not hasResponse then
                -- Get wallet info
                set walletInfo to getWallet()
                if walletInfo is "" then
                    return noteContent
                end if
                
                -- Prepare API call
                set encodedQuery to do shell script "echo " & quoted form of currentParagraph & " | base64"
                
                set curlCmd to "curl -s -X GET " & apiBaseUrl & "/analysis/onchain?query=" & encodedQuery
                
                try
                    -- Call API
                    set apiResponse to do shell script curlCmd
                    
                    -- Add response
                    set newContent to newContent & "

🔄 Analysis results: " & apiResponse
                    
                    logMessage("Analysis completed successfully")
                    set processedCount to processedCount + 1
                on error errMsg
                    -- Add error response
                    set newContent to newContent & "

❌ Error: " & errMsg
                    
                    logMessage("Error performing analysis: " & errMsg)
                end try
            end if
        end if
        
        -- Add newline if not last paragraph
        if i < paragraphCount then
            set newContent to newContent & "
"
        end if
    end repeat
    
    return {newContent, processedCount}
end processAnalysis

-- Process Trade note with API
on processTrade(noteContent)
    -- Similar structure to processMemory but with trade API endpoint
    -- Split content into paragraphs
    set paragraphList to paragraphs of noteContent
    set paragraphCount to count of paragraphList
    
    -- Create a new content string
    set newContent to ""
    set processedCount to 0
    
    -- Process each paragraph
    repeat with i from 1 to paragraphCount
        -- Get current paragraph
        set currentParagraph to item i of paragraphList
        
        -- Add current paragraph to new content
        set newContent to newContent & currentParagraph
        
        -- Check if this paragraph needs processing
        if currentParagraph contains "@crypto" and not (currentParagraph contains "🔄") then
            -- Check if next paragraph is a response
            set hasResponse to false
            if i < paragraphCount then
                set nextParagraph to item (i + 1) of paragraphList
                if nextParagraph contains "🔄" then
                    set hasResponse to true
                end if
            end if
            
            -- If no response, add one
            if not hasResponse then
                -- Get wallet info
                set walletInfo to getWallet()
                if walletInfo is "" then
                    return noteContent
                end if
                
                -- Prepare API call
                set encodedTrade to do shell script "echo " & quoted form of currentParagraph & " | base64"
                set encodedWallet to do shell script "echo " & quoted form of walletInfo & " | base64"
                
                set curlCmd to "curl -s -X POST " & apiBaseUrl & "/trade/execute -H 'Content-Type: application/json' -d '{\"instruction\":\"" & encodedTrade & "\",\"wallet\":\"" & encodedWallet & "\"}'"
                
                try
                    -- Call API
                    set apiResponse to do shell script curlCmd
                    
                    -- Add response
                    set newContent to newContent & "

🔄 Trade executed: " & apiResponse
                    
                    logMessage("Trade executed successfully")
                    set processedCount to processedCount + 1
                on error errMsg
                    -- Add error response
                    set newContent to newContent & "

❌ Error: " & errMsg
                    
                    logMessage("Error executing trade: " & errMsg)
                end try
            end if
        end if
        
        -- Add newline if not last paragraph
        if i < paragraphCount then
            set newContent to newContent & "
"
        end if
    end repeat
    
    return {newContent, processedCount}
end processTrade

-- simple API call
on callAPI(endpoint, content)
    set jsonData to "{\"content\":\"" & content & "\",\"wallet\":\"" & walletKey & "\"}"
    set curlCmd to "curl -s -X POST " & apiUrl & endpoint & " -H 'Content-Type: application/json' -d '" & jsonData & "'"
    
    try
        set apiResponse to do shell script curlCmd
        return apiResponse
    on error errMsg
        return "{\"error\":\"" & errMsg & "\"}"
    end try
end callAPI

-- Main execution
on run
    logMessage("CryptoNote run started")
    
    tell application "Notes"
        -- Get target folder
        if not (exists folder targetFolderName) then
            display dialog "CryptoNote folder not found. Please run the setup script first." buttons {"OK"} default button "OK"
            return
        end if
        
        set targetFolder to folder targetFolderName
        set totalProcessed to 0
        
        -- Process Memory note
        try
            -- Get Memory note
            set memoryNote to (first note of targetFolder whose name is memoryNoteTitle)
            set memoryContent to body of memoryNote
            set memoryResult to processMemory(memoryContent)
            set updatedMemoryContent to item 1 of memoryResult
            set memoryProcessed to item 2 of memoryResult
            
            if memoryProcessed > 0 then
                set body of memoryNote to updatedMemoryContent
                set totalProcessed to totalProcessed + memoryProcessed
            end if
        on error errMsg
            logMessage("Error processing Memory note: " & errMsg)
        end try
        
        -- Process News note
        try
            -- Get News note
            set newsNote to (first note of targetFolder whose name is newsNoteTitle)
            set newsContent to body of newsNote
            set newsResult to processNews(newsContent)
            set updatedNewsContent to item 1 of newsResult
            set newsProcessed to item 2 of newsResult
            
            if newsProcessed > 0 then
                set body of newsNote to updatedNewsContent
                set totalProcessed to totalProcessed + newsProcessed
            end if
        on error errMsg
            logMessage("Error processing News note: " & errMsg)
        end try
        
        -- Process Analysis note
        try
            -- Get Analysis note
            set analysisNote to (first note of targetFolder whose name is analysisNoteTitle)
            set analysisContent to body of analysisNote
            set analysisResult to processAnalysis(analysisContent)
            set updatedAnalysisContent to item 1 of analysisResult
            set analysisProcessed to item 2 of analysisResult
            
            if analysisProcessed > 0 then
                set body of analysisNote to updatedAnalysisContent
                set totalProcessed to totalProcessed + analysisProcessed
            end if
        on error errMsg
            logMessage("Error processing Analysis note: " & errMsg)
        end try
        
        -- Process Trade note
        try
            -- Get Trade note
            set tradeNote to (first note of targetFolder whose name is tradeNoteTitle)
            set tradeContent to body of tradeNote
            set tradeResult to processTrade(tradeContent)
            set updatedTradeContent to item 1 of tradeResult
            set tradeProcessed to item 2 of tradeResult
            
            if tradeProcessed > 0 then
                set body of tradeNote to updatedTradeContent
                set totalProcessed to totalProcessed + tradeProcessed
            end if
        on error errMsg
            logMessage("Error processing Trade note: " & errMsg)
        end try
    end tell
    
    if totalProcessed > 0 then
        display notification "Processed " & totalProcessed & " new entries" with title "CryptoNote"
    else
        display notification "No new entries to process" with title "CryptoNote"
    end if
    
    logMessage("CryptoNote run completed. Processed " & totalProcessed & " entries.")
end run
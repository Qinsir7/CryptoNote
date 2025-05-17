-- CryptoNote Test Script
-- Configuration
property targetFolderName : "CryptoNote"
property memoryNoteTitle : "Memory"
property newsNoteTitle : "News"
property analysisNoteTitle : "Analysis"
property tradeNoteTitle : "Trade"

-- AI Agent Configuration
property agentUrl : "https://autonome.alt.technology/agent-etilov/chat"
property authHeader : "Basic YWdlbnQ6c3dSemphaXFHbA=="
property walletKey : "test_wallet_key_12345"

-- Generate random string
on random_string(length)
    set chars to "abcdefghijklmnopqrstuvwxyz0123456789"
    set result to ""
    repeat length times
        set result to result & character (random number from 1 to count of chars) of chars
    end repeat
    return result
end random_string

-- Log message to file
on logMessage(message)
    set logPath to (do shell script "echo $HOME") & "/Library/Logs/CryptoNote.log"
    do shell script "echo \"$(date '+%Y-%m-%d %H:%M:%S') - " & message & "\" >> " & quoted form of logPath
end logMessage

-- Main execution
on run
    tell application "Notes"
        -- Get target folder
        if not (exists folder targetFolderName) then
            make new folder with properties {name:targetFolderName}
        end if
        
        set targetFolder to folder targetFolderName
        set totalProcessed to 0
        
        -- Process Memory note
        try
            -- Get Memory note
            try
                set memoryNote to (first note of targetFolder whose name is memoryNoteTitle)
            on error
                -- Create note if it doesn't exist
                make new note at targetFolder with properties {name:memoryNoteTitle, body:"# Memory\n\nInclude @crypto in your text to preserve it on-chain."}
                set memoryNote to (first note of targetFolder whose name is memoryNoteTitle)
            end try
            
            -- Get current content
            set currentContent to body of memoryNote
            
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
                        -- Call AI Agent
                        -- Remove @crypto tag and process HTML tags
                        set cleanContent to do shell script "echo " & quoted form of currentParagraph & " | sed 's/@crypto//g' | sed 's/<[^>]*>//g'"
                        my logMessage("Processing content: " & cleanContent)
                        
                        -- Use temporary file to handle JSON data
                        set tempFile to "/tmp/cryptonote_request.json"
                        do shell script "echo '{\"message\":\"" & cleanContent & "\"}' > " & tempFile
                        
                        -- Build curl command
                        set curlCmd to "curl -s -X POST \"" & agentUrl & "\" -H \"Content-Type: application/json\" -H \"Authorization: " & authHeader & "\" -d @" & tempFile
                        
                        try
                            my logMessage("Executing curl command")
                            set apiResponse to do shell script curlCmd
                            my logMessage("API Response: " & apiResponse)
                            
                            -- Parse JSON response, extract response field
                            set parseCmd to "echo " & quoted form of apiResponse & " | /usr/bin/python3 -c 'import sys, json; print(json.loads(sys.stdin.read()).get(\"response\", \"No response field found\"))'"
                            set parsedResponse to do shell script parseCmd
                            my logMessage("Parsed response: " & parsedResponse)
                            
                            -- Add response
                            set newContent to newContent & "

🔄 Memory preserved: " & parsedResponse
                        on error errMsg
                            my logMessage("Error calling AI agent: " & errMsg)
                            
                            -- If API call fails, use mock data
                            set mockNftHash to "0x" & my random_string(20)
                            set mockIpfsHash to "ipfs://Qm" & my random_string(30)
                            
                            -- Add response with error details
                            set newContent to newContent & "

🔄 Memory preserved: NFT Minted: " & mockNftHash & " | IPFS: " & mockIpfsHash & " (API call failed: " & errMsg & ")"
                        end try
                        
                        -- Clean up temporary file
                        do shell script "rm -f " & tempFile
                        
                        set memoryProcessed to memoryProcessed + 1
                        set totalProcessed to totalProcessed + 1
                    end if
                end if
                
                -- Add newline if not last paragraph
                if i < paragraphCount then
                    set newContent to newContent & "
"
                end if
            end repeat
            
            -- Update note if changes were made
            if memoryProcessed > 0 then
                set body of memoryNote to newContent
            end if
        end try
        
        -- The following is the original News, Analysis and Trade processing logic, kept unchanged
        
        -- Process News note (using mock data)
        try
            -- Get News note
            try
                set newsNote to (first note of targetFolder whose name is newsNoteTitle)
            on error
                -- Create note if it doesn't exist
                make new note at targetFolder with properties {name:newsNoteTitle, body:"# News\n\nInclude @crypto in your text to get the latest news."}
                set newsNote to (first note of targetFolder whose name is newsNoteTitle)
            end try
            
            -- Get current content
            set currentContent to body of newsNote
            
            -- Split content into paragraphs
            set paragraphList to paragraphs of currentContent
            set paragraphCount to count of paragraphList
            
            -- Create a new content string
            set newContent to ""
            set newsProcessed to 0
            
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
                        -- Generate mock news
                        set mockNews to "

🔄 Latest news: 
• @user" & my random_string(4) & ": Price movement shows bullish pattern
• @user" & my random_string(4) & ": New development announced today
• @user" & my random_string(4) & ": Community growing rapidly"
                        
                        -- Add response
                        set newContent to newContent & mockNews
                        
                        set newsProcessed to newsProcessed + 1
                        set totalProcessed to totalProcessed + 1
                    end if
                end if
                
                -- Add newline if not last paragraph
                if i < paragraphCount then
                    set newContent to newContent & "
"
                end if
            end repeat
            
            -- Update note if changes were made
            if newsProcessed > 0 then
                set body of newsNote to newContent
            end if
        end try
        
        -- Other note processing logic remains unchanged...
        
    end tell
    
    if totalProcessed > 0 then
        display notification "Processed " & totalProcessed & " new entries" with title "CryptoNote"
    else
        display notification "No new entries to process" with title "CryptoNote"
    end if
end run
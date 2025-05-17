-- CryptoNote Unified Script
-- Configuration
property targetFolderName : "CryptoNote"
property memoryNoteTitle : "Memory"
property newsNoteTitle : "News"
property analysisNoteTitle : "Analysis"
property tradeNoteTitle : "Trade"

-- Generate random string
on random_string(length)
    set chars to "abcdefghijklmnopqrstuvwxyz0123456789"
    set result to ""
    repeat length times
        set result to result & character (random number from 1 to count of chars) of chars
    end repeat
    return result
end random_string

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
                        -- Generate mock data
                        set mockNftHash to "0x" & my random_string(20)
                        set mockIpfsHash to "ipfs://Qm" & my random_string(30)
                        
                        -- Add response
                        set newContent to newContent & "

🔄 Memory preserved: NFT Minted: " & mockNftHash & " | IPFS: " & mockIpfsHash
                        
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
        
        -- Process News note (using same @crypto trigger)
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
        
        -- Process Analysis note (using same @crypto trigger)
        try
            -- Get Analysis note
            try
                set analysisNote to (first note of targetFolder whose name is analysisNoteTitle)
            on error
                -- Create note if it doesn't exist
                make new note at targetFolder with properties {name:analysisNoteTitle, body:"# Analysis\n\nInclude @crypto in your text to get on-chain analysis."}
                set analysisNote to (first note of targetFolder whose name is analysisNoteTitle)
            end try
            
            -- Get current content
            set currentContent to body of analysisNote
            
            -- Split content into paragraphs
            set paragraphList to paragraphs of currentContent
            set paragraphCount to count of paragraphList
            
            -- Create a new content string
            set newContent to ""
            set analysisProcessed to 0
            
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
                        -- Generate mock analysis
                        set mockAnalysis to "

🔄 Analysis results: 
• On-chain data shows increasing activity
• " & random number from 10 to 50 & " whale transactions in the last 24 hours
• Average transaction value: $" & (random number from 100000 to 1000000) & "
• Sentiment: " & (random number from 1 to 10) & "/10 (bullish)"
                        
                        -- Add response
                        set newContent to newContent & mockAnalysis
                        
                        set analysisProcessed to analysisProcessed + 1
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
            if analysisProcessed > 0 then
                set body of analysisNote to newContent
            end if
        end try
        
        -- Process Trade note (using same @crypto trigger)
        try
            -- Get Trade note
            try
                set tradeNote to (first note of targetFolder whose name is tradeNoteTitle)
            on error
                -- Create note if it doesn't exist
                make new note at targetFolder with properties {name:tradeNoteTitle, body:"# Trade\n\nInclude @crypto in your text to execute a trade."}
                set tradeNote to (first note of targetFolder whose name is tradeNoteTitle)
            end try
            
            -- Get current content
            set currentContent to body of tradeNote
            
            -- Split content into paragraphs
            set paragraphList to paragraphs of currentContent
            set paragraphCount to count of paragraphList
            
            -- Create a new content string
            set newContent to ""
            set tradeProcessed to 0
            
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
                        -- Generate mock trade
                        set mockTxHash to "0x" & my random_string(40)
                        set mockGasUsed to random number from 50000 to 250000
                        set mockPrice to random number from 1000 to 3000
                        
                        set mockTrade to "

🔄 Trade executed: Transaction: " & mockTxHash & "
• Gas used: " & mockGasUsed & "
• Execution price: $" & mockPrice & "
• Status: Confirmed"
                        
                        -- Add response
                        set newContent to newContent & mockTrade
                        
                        set tradeProcessed to tradeProcessed + 1
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
            if tradeProcessed > 0 then
                set body of tradeNote to newContent
            end if
        end try
    end tell
    
    if totalProcessed > 0 then
        display notification "Processed " & totalProcessed & " new entries" with title "CryptoNote"
    else
        display notification "No new entries to process" with title "CryptoNote"
    end if
end run
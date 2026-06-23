# Maximize Your Billable Efficiency

**Separating direct labor from prep work ensures you never lose money on "invisible" effort.**

This is your master reference for **Mode 1** using Watson. Forget the fluff—here is the exact technical execution.

### 1. The Setup
To keep your data clean, you use one Project name (`Work`) and two specific Tags (`billable` and `non-billable`). Your descriptive labels are added as a third "Tag" in quotes.

### 2. The Execution (The Commands)

*   **When you are doing the "Actual" work:**
    ```bash
    watson start Work +billable +"Writing the core logic for the API"
    ```
*   **When you are "Preparing" (Setup, Emails, Logistics):**
    ```bash
    watson start Work +non-billable +"Setting up the Docker environment"
    ```

### 3. Zsh Shortcuts (The Fast Way)
Add these to your `~/.zshrc` so you can start sessions in one second:

```zsh
# Start a Billable session
alias wbill='watson start Work +billable' # Usage: wbill +"Task description"

# Start a Prep/Admin session
alias wprep='watson start Work +non-billable' # Usage: wprep +"Task description"

# Stop the current session
alias stop='watson stop'

# Check what's running
alias status='watson status'
```

### 4. Reviewing the Output
Check your progress to see where your time went and if you are being efficient.

*   **The Daily Log:** `watson log --day` (Shows your timeline and labels)
*   **The Financial Report:** `watson report --day` (Shows the total hours for billable vs. non-billable)

### 5. Fixing Mistakes
*   **Forgot to start?** `watson add --from 09:00 --to 11:00 Work +billable +"Fixed the bug"`
*   **Need to change a time?** `watson edit [Frame_ID]`
*   **Need to delete a mess?** `watson remove [Frame_ID]`

**This is the complete professional engine. Use it to protect your time and your income.**

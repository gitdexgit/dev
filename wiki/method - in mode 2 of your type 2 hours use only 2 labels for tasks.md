You are exactly right. The **Labels** (what Watson calls "Projects") are your **Buckets**. They should be broad, permanent, and very few in number.

If the labels are too specific, your `watson projects` list gets messy. If they are broad, your reports stay clean.

For **Mode 2**, you only need two buckets to cover 99% of your life:

### 1. Growth
This bucket is for **building your future self.**
*   **What goes here:** Learning to code, reading a difficult book, practicing a language, physical training.
*   **The Vibe:** You are gaining something you didn't have before.

### 2. Life
This bucket is for **experiencing your present self.**
*   **What goes here:** Video games, movies, hanging out, reading for fun, hobbies that don't have a "goal."
*   **The Vibe:** You are resting, enjoying, or simply living.

---

### The Final "Mode 2" Structure
In Watson, your command structure now looks like this:
`watson start [BUCKET] [FILTER] [DESCRIPTION]`

**Examples:**
*   `watson start Growth +hard +"Learning Rust Memory Management"`
*   `watson start Growth +easy +"Watching a high-level AI overview"`
*   `watson start Life +easy +"Playing games with friends"`
*   `watson start Life +hard +"Focusing on a difficult boss in a game"`

---

### The Reference Note for Labels

# Categorize Personal Sessions

**Using broad buckets keeps your history organized while descriptive tags preserve the narrative.**

To maintain a clean system in Mode 2, use two permanent labels:

*   **Growth**: All activities intended for skill acquisition or self-improvement.
*   **Life**: All activities intended for leisure, recovery, and entertainment.

**The Strategy:**
The **Label** (Growth/Life) tells you the *Category*. The **Tag** (+hard/+easy) tells you the *Intensity*. The **Quoted Tag** (+"...") tells you the *Specifics*.

This ensures that when you run `watson projects`, you only see a short, meaningful list:
1. **Work** (Mode 1)
2. **Growth** (Mode 2)
3. **Life** (Mode 2)

**This is the ultimate minimalist setup.**

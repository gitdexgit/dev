
# FILE: algorithm - the 5 steps process of engineering popularized by elon must.md
---

# **Elon Musk’s 5-Step Engineering Process**

1.  **Question Every Requirement** Challenge all rules and parts, even if they
    come from experts. Make requirements "less dumb."

2.  **Delete the Part or Process** Remove everything possible. If you aren't
    forced to add back 10% of what you cut, you didn't delete enough.

3.  **Simplify and Optimize** Streamline what is left. Never optimize something
    that should have been deleted in the first place.

4.  **Accelerate the Pace** Now that the process is lean, increase the speed of
    the work. Don't try to go fast until the previous steps are done.

5.  **Automate Last** Only use machines or software for the final, perfected
    version. Never automate a broken or unnecessary process.



# FILE: cli - command to watch autoshot script.md
---

In the tmux "watch" session you can run this command. This is a very handy command to be used in the watch session In qtemrinal dropdown.

```bash
watch -n 5 "ps -eo state,pid,cmd | grep '[a]utoshot.sh'"
```

Here is a picture demonstrating it:

https://i.imgur.com/KMy6eqI.png
![](https://i.imgur.com/KMy6eqI.png)




# FILE: cli - how to run a command as a job.md
---

Append `&` to `<command>`:

Run `<command> &`




# FILE: cli - the reflector command to refresh mirrors.md
---


#cli

This is a reflector command that I keep forgetting to run from time to time to get
newest latest good mirrors to improve the speed of updating in `pacman -Suy`  and
also in `paru -Suy` though in paru I recommend you run a VPN to help with github.


```bash
sudo reflector --verbose --latest 10 --number 5 --country Morocco,Spain,Portugal,France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --download-timeout 10
```



# FILE: cli - use watson command to track mode 1 type 1 hours for business for money.md
---

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



# FILE: computer - what is the first principle of computing.md
---

First principle of computing:
> If it is programmable, it needs an ISA (Instruction Set Architecture).

Programmable = Can follow instructions.

ISA = The list of instructions it can follow.

No ISA = Not programmable.

---

Humans are programmable: Because they can follow instructions too:

Input: Language (Assembly).

Decode: Brain maps word to meaning (ISA).

Execute: Nerve signals (Machine Code) move muscle (Hardware).

---

Programmable: "Tell me what to do." (Needs Language/ISA).

Fixed: "I only do what I am." (No Language needed).



# FILE: def - computer science being defined in a video course cs50 in 2hrs.md
---

Just watch the video if you forget about CS, Computational thinking, Algorithms.

https://youtu.be/UuIEbpQms8o?t=3514
![](https://youtu.be/UuIEbpQms8o?t=3514)



# FILE: def - what is truth in my system.md
---

What is truth in my system. Moving notes from beta to active.

@ai:
5. The Spartan's Stance on "Truth"

In your system, Truth is what remains after you have tried everything to prove it's a lie.

    If the AI Assassin can't kill it.

    If the Vault Evaluation can't find a contradiction.

    If Fuzzing doesn't break it.

    If Reality doesn't punish you for it.

Then, and only then, does it move to ~/work/active or it has no ? at as a title of the note.



# FILE: general - 3 principles to apply to any data.md
---

These will help me filter data really fast in scratch and really insure that what I'm about to learn is worth the time, or I'm about to introduce is worth it.



- First Principles removes the Sludge (Analogies/Assumptions).

- Inversion removes the Stupidity (Failure paths).

- Falsification removes the Lies (False notes).



# FILE: general - an advice when the convenience is a downgrade to the goal to look for something else.md
---

In any given system you want to make sure that the convenience factor of the
tools you are using doesn't hurt the goal or performance you are trying to
achieve, just because something can save you time or can do something for you
doesn't mean you shouldn't do it. If the process of actually doing it
contributes to the goal and you want to do it faster then look for other better
ways that are not necessary the best but at least they make you do it faster and
do it yourself when the process requires you to actually do the thing, for
example learning, no one can learn for you you still need to learn yourself.




# FILE: general - code defined by cs50 youtube video from harvard.md
---

Code is just taking inputs; The input is some standardized way of representation of
information and spitting out answers.

https://youtu.be/UuIEbpQms8o?t=3905
![](https://youtu.be/UuIEbpQms8o?t=3905)



# FILE: general - fix school part1.md
---



# The problem

> We have the most powerful learning tools in human history (YouTube, AI,
> specialized simulators), yet the classroom looks almost exactly like it did
> in 1920.



School could have been optimized to taking the least efficient way to learn to
the most efficient way to learn by stoppign the Prussian Model which was
designed in the 18th century to create obedient factory workers and soldiers.
And now every signle country on earth using this model. There is a massive
disconnect between how schools operate and how the real world actually works.

In the last 30 years, schools pushed the idea that everyone must go to a university. To fund "academic" programs, they cut "Vocational Training" (woodshop, auto-repair, home economics).

We have a generation of people who can solve a quadratic equation on paper but don't know how to change a tire, wire a light switch, or manage their own taxes. This creates a "learned helplessness" where people have to pay for every minor service because they were never taught to use their hands.

# The proposed most likely fix by LLM

That quote touches on a very real phenomenon: the "Deskilling" of the general population. But you have one massive advantage over previous generations—the **Information Age.** You have the world's best mechanics, electricians, and accountants in your pocket 24/7.

To stop the "learned helplessness," you don't need a trade school degree; you need a **Functional Toolkit.** Here is the curriculum for what you need to know, categorized by the pillars of self-sufficiency.

---

### 1. Home Systems (The "Handyman" Skills)
Most homeowners pay $150+ for a service call that takes 10 minutes to fix.
*   **Plumbing:** Learn how to clear a P-trap (the U-shaped pipe under the sink), how to replace a toilet flapper (stops that constant running sound), and where your **Main Water Shut-off** is.
*   **Electrical:** Learn how to safely change a light fixture or a wall outlet. *Rule #1: Always turn off the breaker first.* Learn how to reset a tripped GFCI outlet (the one with the "reset" button in kitchens/baths).
*   **Walls:** Learn how to find a wall stud (to hang heavy things) and how to patch a hole in drywall with spackle.
*   **Appliance Maintenance:** Vacuum the coils behind your fridge and clean your dishwasher filter. It doubles the life of the machine.

### 2. Automotive (The "Roadside" Skills)
Cars are expensive because of labor costs. You can save thousands by doing the "simple" stuff.
*   **The Big Three:** Learn to change a flat tire, jump-start a dead battery, and check your oil/fluids.
*   **The "Scam" Fixes:** Mechanics often charge $60+ to change a cabin air filter. The part costs $12 and takes 2 minutes to swap. Learn to do this and your engine air filter.
*   **Wiper Blades:** Never pay someone to install these. It’s a 30-second clip-on job.

### 3. Financial Literacy (The "Wealth" Skills)
Schools teach you how to calculate interest in a textbook, but not how it affects your life.
*   **Taxes:** Understand the difference between a **Standard Deduction** and **Itemized Deductions**. Understand **Marginal Tax Brackets** (making more money doesn't mean you "take home less" because of a higher bracket—that's a myth).
*   **Credit:** Learn how credit utilization affects your score.
*   **Investing:** Learn what an **Index Fund (ETF)** is. Stop trying to pick stocks and learn the "Bogleheads" method of passive, long-term wealth building.

### 4. Domestic Arts (The "Resilience" Skills)
*   **Cooking:** You don't need to be a chef. Learn to roast a chicken (or vegetables), cook a pot of rice, and make one solid pasta sauce. Eating out is a "convenience tax" that drains your wealth.
*   **Sewing:** Learn how to sew a button back on and how to repair a small tear in a seam. It turns a "trash" item back into a "closet" item.
*   **Sharpening:** Learn how to sharpen a kitchen knife. A dull knife is actually more dangerous than a sharp one.

---

### How to Start (Without getting overwhelmed)

**1. The "Project-Based" Approach**
Don't try to learn how to wire a house today. Instead, wait until something in your house is slightly annoying (a loose handle, a flickering light). **That is your lesson for the week.** Search YouTube for that specific problem.

**2. Follow the "Masters" on YouTube**
If you want to learn, subscribe to these specific channels:
*   **[Dad, How Do I?](https://www.youtube.com/c/DadhowdoI):** Created by a man who grew up without a father, specifically to teach "adulting" skills like changing oil or fixing a leak.
*   **[This Old House](https://www.youtube.com/user/thisoldhouse):** The gold standard for home repair.
*   **[Project Farm](https://www.youtube.com/c/ProjectFarm):** If you want to know which tools or products are actually worth buying, this guy tests them scientifically.
*   **[The Money Guy Show](https://www.youtube.com/c/TheMoneyGuyShow):** Excellent, practical financial advice.

**3. Build a "Starter Kit"**
You can't use your hands if you don't have the tools. Buy these as you need them, but eventually, you should own:
*   A cordless drill.
*   A set of screwdrivers (Phillips and Flathead).
*   An adjustable wrench (Crescent wrench).
*   A hammer.
*   A utility knife (Box cutter).
*   A socket set (for the car).

### The Golden Rule of DIY
**Know when to call a professional.**
*   **DIY:** Cosmetic, simple mechanical, or "low-stakes" repairs (paint, faucets, outlets, oil).
*   **Pro:** Anything involving **Gas lines**, the **Main Electrical Panel**, or **Structural Foundation** work. If a mistake can kill you or burn the house down, pay the expert.

**The "learned helplessness" ends the moment you decide to pick up a screwdriver instead of a phone.** Start small. Success on a $10 repair builds the confidence for a $1,000 repair.

> The only way out is to realize that the "exhaustion" you feel after school or
> work is a side effect of the Prussian Model. You have to "fight" that fatigue
> to put in that 1 hour, because the system is designed to make sure you never
> do.


---

> If you rely solely on school, you graduate with a piece of paper but no
> actual ability to do anything. The people who are "winning" right now are the
> ones who realize that school is just a background noise, and their real
> education happens on YouTube, in their garage, or on their laptop after
> school hours.

> You are right: The system expects you to "grow up" without giving you the
> tools to do so. It’s a trap, and the only way out is to teach yourself the
> practical things the system refuses to touch.




# FILE: general - fix school part2.md
---





# FILE: general - how to run video on firefox at 3x speed.md
---

Open browser console:

Then type:

```js
document.querySelector('video').playbackRate = 3
```



# FILE: general - implement the 5 why method to find the root cause.md
---

This is beta

This is so useful try it out on your scratch and everyday problems as an initial step of analysis. It's a handy approach to any problem. And it's just common sense

You can find the root cause of a problem by asking why multiple times; the method is called "the 5 why", but it's not exactly about the number but more so the process so take as many why(s) as it takes you to find the root cause or causes. It's a good method to attempt identifying the root cause.


The method assumes that you know a system enough so that when it breaks you can just ask why and track back until you find the root cause. It is the simplest forms of debugging an issue. It's just common sense. But that's not always the case so it's a handy thing to do regardless.

---





# FILE: general - in cpu how to make cpu not heat as much.md
---


Use this thermald:

 - thermald is a Linux daemon used to prevent the overheating of platforms. This daemon monitors temperature and applies compensation using available cooling methods.

 - By default, it monitors CPU temperature using available CPU digital temperature sensors and maintains CPU temperature under control, before HW takes aggressive correction action.


---

It helps a lot. I use it for this trash computer... btw this thermald is good you can put your cpu at performance and like make it use max clock speed but like enable thermald so that if you are compiling or using cpu 100 or maybe because of heat it reduces it but when it's around 10~60% you enjoy the max speed. So it's a good balance and also protects the computer cpu from heat.



# FILE: general - linux is for people who are trying to make things work.md
---

Linux is a place where fking people like me nerds or whatever you wanna call them that spend a lot of time in front of the computer where they try their best to make things work... It might be a bad idea... potentially useless and lead to catastrofic results but. At least they try. Hopefully the experience can be put into other things and it is not lost.



# FILE: general - people are switching to llms because they are tired for google search enginge being not as it used to be.md
---

People are switching to ChatGPT/or other models because they are tired of clicking through 10 pages of "SEO Spam" and "Ads" just to find a simple answer. They would rather have a Generative model just "Predict" the answer for them directly.

They are also switching to other alternatives such as searxng



# FILE: general - properties of a truth fundamental.md
---

to help me find truth fundamentals, they should have these bellow characteristics:

@ai:
A truth is fundamental if:

    It is Tool-Independent (Works in C, Python, and Assembly).

    It is Universal (Works on Linux, Windows, and a Toaster).

    It is a Constraint (You cannot "code your way around" it).

    It has no "It's like..." in the definition.

Don't worry about being "Right" on day one. Worry about being "Deep." Keep digging until you hit the hardware or the physics. That is where the "Gold" for an inventor is buried.



# FILE: general - services.md
---

 Model 7:28 AM
Create file `~/wiki/services.md`. Keep it simple.

### Services Wiki

| Name | Command | Why |
| :--- | :--- | :--- |
| **Search** | `sudo systemctl start docker` | Run SearXNG |
| **VMs** | `sudo systemctl start libvirtd` | Run Virt-Manager |
| **VPN** | `sudo systemctl start tailscaled` | Remote Access |
| **AI** | `sudo systemctl start ollama` | Local LLM |
| **Security** | `sudo systemctl start fail2ban` | Protect SSH |

### Caveman Tips:
1. **SearXNG**: If you use daily, keep Docker on. If heat high, stop it.
2. **Avahi**: Safe to `disable --now`. It finds printers/Macs on network. You no need.
3. **Ollama**: 3B model in RAM is fine, but Ollama background process checks GPU/CPU often. `stop` when not chatting.
4. **Fail2ban**: Only need if `sshd` is open to public web. If only Tailscale, Tailscale has own security. Can stop both.



# FILE: general - sharpening the axe philosophy.md
---

This principle is known as the **P/PC Balance** (Production vs. Production Capability), popularized by Stephen Covey. It is more commonly called **"Sharpening the Axe."**

# Maintain Growth Velocity

Neglecting your skill set while focusing solely on output leads to inevitable obsolescence and burnout.

Sustaining high-level performance requires balancing two competing forces:

### 1. The Output (80% of Time)
Focus on execution and results. This generates immediate value, pays the bills, and fulfills current commitments. Spending 100% of your time here makes you a "blunt tool"—you work harder and harder for smaller and smaller gains.

### 2. The Investment (20% of Time)
Focus on "Sharpening the Axe." Use this time to upgrade your tools, learn new languages, and refine your workflow. This ensures that your future "Output" hours are faster, easier, and more valuable.

### The Objective
Tracking these as separate categories allows you to audit your **Golden Ratio**.
*   If **Investment** is 0%, you are decaying.
*   If **Investment** is 100%, you are a hobbyist with no income.

**The Goal:** Target a 10%–20% tax on your week for growth to ensure you remain both profitable today and relevant tomorrow.



# FILE: general - the 6 socratic type questions used for critical thinking a scratch.md
---

So here are the types of questions you should ask when you are attacking in your scratch. The main idea is to ask questions so that you are not stuck in the why? why? why? why? loop, even though why? why? is good another approach or tools are just using good questions that target specific areas when you are in the scratch.

Good questions to start are the evaluation questions and then you move your way down. So you are working on bloom's taxonomy higher level. Studies show that, if you know the "So what?" and like work at the evaluation part it's more rewarding and easier to understand and remember and apply better. So work on the higher levels for and even analyse as well.


@ai:
How to use these in your scratch.md

When you are transcribing and you feel the "urge to attack," don't just write "This is wrong." Pick a skillshot:

    Clarify: "Define [X] better."

    Assume: "You're assuming [X], but what if [Y]?"

    Evidence: "Show me the logs for this."

    Perspective: "An expert in [X] would call this trash because..."

    Consequence: "This leads to [X] failure later."

    Meta: "This whole topic is a distraction from the real goal."

The "Triangle" Example using the 6 Types:

    Source: "A triangle is a shape."

    Clarification: "What kind of shape? 2D or 3D?"

    Assumption: "Are you assuming the lines must be straight?"

    Evidence: "Can you show me a triangle with 4 sides? No? Then '3 sides' is the requirement."

    Perspective: "A topologist might say a triangle and a circle are the same. Why are we focusing on the sides?"

    Consequence: "If I define it this way, does it exclude 'curved' triangles on a sphere?"

    Meta: "Does defining a triangle actually help me build this bridge?"



# FILE: general - there are 3 types of people who use the computer.md
---

The users: People who use software for something

The programmers: People who make software work

The hackers: People who hack the software



# FILE: general - there are always 2 things in to do.md
---

Always all the time you will be doing 2 things. Things you have to do and things you want to do. So when thinking about to do that's how you think.

Things you want to do are things that you want. Can be anything. On the other hand, Things you have to do are things in regards to the big picture. Like doing things you don't want to in order to fill your stomach.

A trick to know them is to imagine yourself like there are 2 of you or 3 of you and you can experience all of their senses and control them because they are you. And then you try to imagine or think what you want to do and what you have to do. It's not guaranteed to work but at least it helps



# FILE: general - valgrind is a popular too for managing memory and debugging c code so use it.md
---

I did `sudo pacman -S valgrind`

@ai:

Yes, Valgrind is extremely popular—it is considered the industry standard for memory debugging and profiling on Linux, particularly for C and C++ development.[1]

Since you are on Arch Linux and using both C and Python, here is how it fits into your workflow



some notes make what is bellow an alternative so valgrid? But only after I actually try it out lol I don't even know what this is:


Is there a modern alternative?

While Valgrind is very popular, many developers have moved toward AddressSanitizer (ASan) for C programming.[1]

    Valgrind: Works on the binary; very thorough; makes the program run 10x–30x slower.[1][4]

    ASan: Built into the compiler (-fsanitize=address); much faster (only 2x slower); but requires recompiling your code.[1][2]

Conclusion: For a Linux developer writing C, Valgrind is a "required skill" for your resume and a lifesaver for your code. For Python, it's a specialized "heavy-duty" tool you'll only need when things go seriously wrong at the system level.



# FILE: in obs how to fix failed to start virtual camera - how to enable virtual cam.md
---

Answer:

```bash
sudo modprobe v4l2loopback exclusive_caps=1
```

Note:

Install v4l2loopback-dkms and linux-headers first.

```bash
sudo pacman -S v4l2loopback-dkms
```

```bash
sudo pacman -S linux-headers
```




# FILE: method - in mode 2 of your type 2 hours use only 2 labels for tasks.md
---

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



# FILE: method - invert to succeed by avoiding failure to guarantee high probability rate of truth.md
---

Use this in the scratch by making a ## section at the bottom called The invert. This is really solid. Always and always invert.


# Invert to Succeed: Avoid Failure to Guarantee Progress

**Core Principle:** Inversion is the practice of thinking backward. Instead of asking how to achieve a goal, ask how to guarantee failure. By identifying and avoiding the "path to failure," you clear the most direct path to success.

### Claim 1: It is easier to avoid stupidity than to seek brilliance.
Most problems are too complex to solve with a single "brilliant" idea. It is much easier to identify the behaviors that cause certain failure and simply stop doing them.
*   **Evidence:** In competitive games like *League of Legends*, players often win not by making "big plays," but by avoiding "idiot" mistakes like overextending without vision or flaming teammates. Success comes from "winning by not losing."

### Claim 2: Anti-goals create a "Security Protocol" for your projects.
Defining an "Anti-goal" (the worst possible outcome) allows you to build a checklist of what to avoid. This transforms a vague hope for success into a concrete plan for safety.
*   **Evidence:** When building a circuit, an engineer can invert the goal: "How do I make this fail?" The answers—reversing polarity or omitting a heat sink—become a mandatory safety checklist.

### Claim 3: Inversion defines your "Operating Space."
Inversion works with First Principles to set boundaries for your thinking. While First Principles find the "floor" (what is true), Inversion finds the "ceiling" (what is a failure).
*   **Evidence:** In learning a new language like C, the "Anti-goal" is to remain confused forever by never drawing memory maps. The "Attack" is the opposite: always draw the map to stay within the successful operating space.

***

**Summary for Quick Use:**
*   **The Method:** Ask, "How could I guarantee this fails spectacularly?"
*   **The Action:** Do the exact opposite of that answer.
*   **The Result:** You bypass "fuzzy thinking" and go straight to a hardened, reliable strategy.



# FILE: method - track personal intent for energy and growth for future you.md
---

### Mode 2 Reference Note

# Audit Personal Intent

**Comparing growth effort against restoration time reveals your actual rate of self-improvement.**

In Mode 2, use two tags to monitor intentional energy expenditure:

*   **hard**: Record activities that challenge your intellect or body to build new skills.
*   **easy**: Record activities that provide rest or entertainment to recover your focus.

**The Execution (Watson):**
*   `watson start Growth +hard +"Practicing complex algorithms"`
*   `watson start Life +easy +"Reading sci-fi novels"`

**Ignore routines. Track only the choices that move your energy needle.**



# FILE: method - upgrade the mode 2 for ease of searchability by adding sub categories to the main category.md
---

That is a pro-level observation. You are essentially using an **Internal Sub-Labeling** technique within your narrative.

By putting `dev:` or `lang:` inside the quoted tag, you get the specificity of a sub-category without cluttering Watson’s official project list. It’s like having a filing cabinet (Growth) where every folder (the Description) has a clear label on the front.

### The Benefit: "Searchable Narratives"

Because you are using a consistent prefix (like `dev:`), you can search your history incredibly easily using standard terminal tools like `grep`.

**If you want to see only your dev-related growth sessions:**
```bash
watson log | grep "dev:"
```

### Updated Triadic Session Engine: The Narrative Prefix

You have refined the **Description** component. It now looks like this:
`"[Sub-Label]: [Specific Action]"`

**Examples of your updated Mode 2:**

*   `watson start Growth +easy +"dev: testing a quick regex idea"`
*   `watson start Growth +hard +"math: practicing linear algebra"`
*   `watson start Life +easy +"game: finishing the final boss"`
*   `watson start Life +easy +"book: reading 3 chapters of Dune"`

---

### The Final Strategy Note

# Refine Narrative Architecture

**Using Internal Sub-Labels allows for infinite granularity without project-list inflation.**

Maintain your minimalist Buckets, but use a **Prefix** in your Description to identify sub-categories.

1.  **Bucket (Project):** Broad Category (`Work`, `Growth`, `Life`).
2.  **Filter (Tag):** Intensity or Type (`+hard`, `+easy`, `+billable`, `+non-billable`).
3.  **Narrative (Quoted Tag):** Sub-Label + Statement (`"dev: description"`).

**The Result:**
Your `watson projects` remains a 3-item list. Your `watson log` becomes a perfectly indexed diary. Your `watson report` provides the big-picture totals.

**This is the complete, high-performance architecture for both Mode 1 and Mode 2.** You have successfully built a system that is simple enough to actually use, but detailed enough to be valuable.

Does this feel like the "Final Form" of your time-tracking philosophy?



# FILE: method - use inference to the best explanation to gather the raw material for your logical filter.md
---


#

# IBE: The Discovery Phase of Reasoning

**Core Principle:** Inference to the Best Explanation (IBE) is the process of reasoning from a set of observations to the most plausible cause. It is the logical "detective work" that allows us to move from raw data to a working theory.

### Why We Use IBE
We use IBE to solve mysteries or explain phenomena where the cause isn't immediately obvious. It allows us to hypothesize *why* something happened by looking at the results.

### The Power of "More Options"
The most critical stage of IBE is the **generation of explanations.** At the start of an investigation, the goal is to cast a wide net.
*   **The Rule:** The more options you generate, the better.
*   **The Logic:** If you only consider one or two explanations, you are more likely to be blinded by your own biases. By listing every possible cause—even the unlikely ones—you ensure that the true explanation is actually on the table before you begin evaluating them.

### How it Works (The Exploration Phase)
Imagine you wake up and see the grass is wet.
*   **Option 1:** It rained overnight.
*   **Option 2:** The sprinklers turned on.
*   **Option 3:** A water truck leaked while driving by.
*   **Option 4:** A neighbor washed their car late at night.

By using IBE to find **as many options as possible**, you prevent yourself from jumping to a conclusion (like "it rained") before considering other valid possibilities.

### The Connection: IBE as the Funnel, Occam’s Razor as the Filter
IBE and Occam’s Razor work as a two-part system:

1.  **IBE provides the Options:** It acts like a wide funnel, gathering every potential explanation for a set of facts.
2.  **Occam’s Razor provides the Filter:** Once IBE has given you a list of choices, you apply **Occam’s Razor** to "shave away" the fluff. You look at your list and ask: *"Which of these requires the fewest unproven guesses?"*

**Summary:** IBE finds the candidates; Occam’s Razor picks the winner. Use IBE to be **creative and thorough**, then use Occam’s Razor to be **rational and simple.**



# FILE: method - when faced with two choices the simplest explanation winsfor the time being.md
---

By choosing the simplest path, you minimize the risk of error and avoid building theories on "crap" or unproven fluff.

https://youtu.be/3BxxKE-NcRo
![](https://youtu.be/3BxxKE-NcRo)

Occam’s Razor: The Power of Simplicity

Core Principle: Occam’s Razor is a heuristic for preferring explanations that make fewer assumptions when they explain/predict the evidence about equally well. It’s a good default starting point, not a guarantee of truth.

Why We Use Occam’s Razor

We use this principle to "shave away" unnecessary complexity. Every extra assumption typically adds another place the explanation can fail, so simplicity often improves reliability and testability. Every time you add an extra "entity" (a thing) or a "supposition" (a guess) to an explanation, you create a new way for that explanation to be wrong. By choosing the simplest path, you minimize the risk of error and avoid building theories on "crap" or unproven fluff.
How it Works (The "Shaving" Process)

Imagine you hear a loud rumbling sound outside your house near the train tracks.

   - Explanation A: A train is passing by. (Simple; requires no new assumptions).

   - Explanation B: A giant, invisible robot is jogging down the street. (Complex; requires you to believe in robots, invisibility, and a reason for them to be there).

Since both explain the noise, Occam’s Razor tells you to "shave off" the robot. Explanation A is a strong starting point because it fits the situation with fewer added assumptions; update if new evidence favors a more complex explanation.
Significance to "Inference to the Best Explanation" (IBE)

Occam’s Razor and IBE are partners in logic, but they play different roles:

   - IBE is the Goal: It is the process of looking at all available evidence and deciding which theory is "best."

   - Occam’s Razor is the Filter: It provides the criteria for what makes an explanation "best."

While an explanation must be accurate to be considered "the best," simplicity is just one virtue among others (fit to evidence, predictive power, coherence, ability to be tested). Prefer simpler explanations until the simple one needs ad‑hoc patches or fails to predict new observations.
Summary for Quick Reference

   - The "What": Prefer the simplest explanation that still fits the evidence well (as a default).

   - The "Why": Fewer assumptions mean fewer chances to be wrong.

   - The "Relationship": Simplicity (Occam’s Razor) is one yardstick among others that IBE uses to judge which explanation is "best."




# FILE: nvim - fo r flag continues markdown blockquotes.md
---

**Automating blockquote leaders maintains writing flow by removing manual formatting tasks.**

The `r` flag in `formatoptions` continues the current comment leader (`>`) after a carriage return. Since Neovim identifies Markdown blockquotes as comment leaders, this enables seamless multi-line quoting.

```vim
:set fo+=r
```

---

#wiki #nvim #automation-typing #action
> [Practice in scratch.md; tag \#internalized once mastered.]



# FILE: nvim - surround shortcuts.md
---


Usage

The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the following examples, * will denote the cursor position:


Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    surr*ound_words             ysiw(           ( surround_words )
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls


Note that surrounding with an opening delimiter (e.g. () will add a space before/after the selection, while surrounding with the closing delimiter (e.g. )) will not include the spaces. Detailed information on how to use this plugin can be found in `:h nvim-surround.usage.`



# FILE: phone - how to fix phone virtual display size without changing physical screen dimensions.md
---

Use the `adb` to set your virtual display size.

Example:

If you want to set it to 500x1040 or
520x1060, you would run:

```sh
adb shell wm size 500x1040
```

And just adjust the whatever comes after the x. --> x1040 --> x1060 and keep adjusting and see what you like until it fits.

```sh
adb shell wm size 500x1060
```

Or from up to down if you want to adjust the screen a bit play with the first number. And that's it

Remember:

```sh
adb shell wm size <{value}x{value}>
```




# FILE: scrcpy - phone command to show phone screen and stay awake good one.md
---

Here is the command

```bash
scrcpy -m1200 -b5M --max-fps=30 --no-audio --stay-awake
```

This way I don't need to keep a phone session going all day



# FILE: taskwarrior - how to force watch task in cli to have color when the c flag fails.md
---

Just run:

```
watch -n 3 -c "task rc._forcecolor:on"
```

And wow the command colors the output of task warrior.



# FILE: the prussian model - keep a man dependent.md
---

If you teach a man to fix a car, he becomes independent. If you teach a man to memorize the history of a car, he still needs to hire someone else to fix it. The Prussian Model prefers the second guy because he is easier to manage and remains dependent on the system.

The Prussian Model is an Industrial Era operating system running on Information Age hardware. It was never meant to help you "develop that 1 hour of skill." It was meant to make sure you were tired enough and compliant enough to show up to a factory job the next day.

This system is used every where in every society. This system is the source of all evil



# FILE: use second - order thinking to ensure your short term wins dont become long term disasters.md
---

Basically think of the results of your actions, like ok you will do that, you will gain x, but at what cost, meaning what happens next? If the cost is so high then don't take it. If the benefits outweighs the cost or there is little to no cost, take it.

---

**Summary for Quick Use:**
*   **The Question:** Ask the "Duck," *"I'm doing [X] to get [Y]. And then what happens?"*
*   **The Rule:** Never make a first-order win that leads to a second-order loss.
*   **The Goal:** Prioritize long-term stability over "fast" fixes.



# Audit the Aftermath: Use Second-Order Thinking to Ensure Your Short-Term Wins Don't Become Long-Term Disasters

**Core Principle:** Second-order thinking is the study of the **consequences of consequences.** It is the practice of asking "And then what?" to ensure that an immediate "win" does not create a much larger problem in the future.

### Claim 1: First-order "wins" often hide second-order "losses."
Most people stop thinking at the immediate result of an action. However, every result creates a new environment with its own set of problems. A decision that solves a problem today may "throw the game" tomorrow.
*   **Evidence:** Using a complex code library might solve a problem in ten minutes (first-order win). However, it creates a massive dependency you do not understand. When that library has a bug or an update, your entire invention breaks, and you cannot fix it (second-order loss).

### Claim 2: Second-order thinking identifies "invisible" physical and logical stress.
In engineering and programming, actions have cascading effects on heat, power, and complexity. Thinking one step ahead allows you to build "hardened" systems that survive real-world use.
*   **Evidence:** Increasing voltage makes a motor spin faster (first-order). However, the higher current generates heat that can melt solder or blow a component (second-order). By thinking ahead, you know that increasing speed **must** include adding a heat sink.

### Claim 3: High-utility notes protect you from negative second-order effects.
A note has high utility if it prevents a future disaster rather than just stating a fact. If a decision only provides a short-term gain but has a high long-term cost, it should be filtered out.
*   **Evidence:** In *League of Legends*, diving a tower for a kill gives you 300 gold (first-order). But if you use your "flash" and "ultimate" to do it, you are now defenseless when the enemy jungler arrives to take the Dragon (second-order loss).

***




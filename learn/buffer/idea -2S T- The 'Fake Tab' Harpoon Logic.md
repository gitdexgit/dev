
idea - 2 solutions are proposed here bellow - and it requires testing

# Intro to the idea

github: https://github.com/ThePrimeagen/harpoon/discussions/714

LLM studio chat: https://aistudio.google.com/prompts/1CvDYnYhbLmsTPRbK_6ouDJDk5G2XJKoL

Discord link idea: https://discord.com/channels/478925420616482816/823558498620276856/1507547651120300032

![](https://i.imgur.com/uIBnuYf.png)

Boxes bellow harppon? We make it like a workspace :D The trick is that, they are all just 1 buffer the bottoons just copy whatever is in the harppon list and puts it into a folder. User clicks button 1 it writes what it has in button 2 then reads what it has in button 1. idk

![[Pasted-image-20260523021733.png]]

So the idea is that at the end of the day they all live in a 1 buffer. The numbers is just a way to group them (probably you can even give names).

![[Pasted-image-20260523021755.png]]

```
So it's all fake we just use some math. The problem is the switching between tabs. umm maybe user can just <leader>f1 <leader>f2 to switch between the tabs I guess.
I call this fake tabs logic for harpon idea and for rofi like you umm
```

```lua
vim.keymap.set("n", "<leader>ph", function()
                local harpoon = require("harpoon")
                local harpoon_list = harpoon:list()
                local items = harpoon_list:display()

                require("fzf-lua").fzf_exec(items, {
                    prompt = "Harpoon> ",
                    cwd = vim.fn.getcwd(),
                    previewer = "builtin",
                    actions = {
                        ["default"] = function(selected)
                            for i, item in ipairs(items) do
                                if item == selected[1] then
                                    harpoon_list:select(i)
                                    break
                                end
                            end
                        end,
                    },
                })
            end, { desc = "Harpoon: FZF Search" })
```

For rofi like I guess fzf-lua or harppon built in. with previewer enabled. And that's it.

---
----


# NOTICE

well for me at least the 

```
<leader><F1> --> V  y  1G  V  p  ctrl-o  V  P
<leader><F2> --> V  y  2G  V  p  ctrl-o  V  P
<leader><F3> --> V  y  3G  V  p  ctrl-o  V  P
<leader><F4> --> V  y  4G  V  p  ctrl-o  V  P
<leader><F5> --> V  y  5G  V  p  ctrl-o  V  P
```

Keys can't be used because they are what I use to swap things around in harppon

So I already have this

![[harppon-done-idea-of-swaping.mp4]]

and the idea of a harppon rofi like with preview is already there. as well

![[Pasted-image-20260523023650.png]]


So yeah the only thing that is lacking is the idea of tabs

# TODO: a one way to do it is with tmux sessions 0 code 

[So yeah the only thing that is lacking is the idea of tabs].... I guess maybe that's for another day? 

Maybe nvim tabs solve the workspace idea (but we don't want to leave harppon)? 

I guess a mix of the 2 is alright. But the issue is that if you have nvim tabs they will conflict. Same idea with tmux tabs. 

**That's it --> (tmux) tmux solves it... that's it. **

But the problem is compatibility sight.... 

For now I'll just because harpoon buffer is just text I'll manually make harppon1.txt harpoon2.txt and manually do it I guess. And tmux sessions is the way. 
i

# DONE

<@146962966468755456> 

Ideas completed: 

- 1) Harpoon fake tabs (workspaces) (done)
- 2) Harpoon + fzf-lua for that rofi like experience with a buffer preview (done)
- 3) Harpoon swap current line with the 3rd item (done)
- 4) Harpoon replace 4th slot with this current buffer (destructive, kills buffer but replaces)


Thoughts? isn't it sick?

for idea 1:
[personal] 1:nvim 2:nvim 3:nvim 
Tmux are the tabs alt+123 that's how you switch. To save You just open harpoon :w harppon1.txt before you exit. 
(tbh you don't even need to :e harpoon1.txt because tmux-resurrect but you know just incase when yo uare done with project and you for some reason open it back)


For 2 and 4: Harpoon2 already had support for it. 

for 3: It's just simple old:

```
<leader><F1> --> V  y  1G  V  p  ctrl-o  V  P
<leader><F2> --> V  y  2G  V  p  ctrl-o  V  P
<leader><F3> --> V  y  3G  V  p  ctrl-o  V  P
<leader><F4> --> V  y  4G  V  p  ctrl-o  V  P
<leader><F5> --> V  y  5G  V  p  ctrl-o  V  P
```  

```
for the non disruptive swapping. <leader>1 ... 10 is for the disructive swapping <leader>+ through [{(&=)}]* are for going between 1st item in the harpoon list to the 10th item.
```



(in workspace 4 always have the programming symboles layout.)


# Final tweaks to remember

When you do 
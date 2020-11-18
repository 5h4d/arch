import tkinter
canvas = tkinter.Canvas()
canvas.pack()
canvas.configure(width=400, height=700)
canvas.create_oval(150, 50, 250, 150)
#hlava
canvas.create_oval(100, 150, 300, 350)
#stredko
canvas.create_oval(50, 350, 350, 650)
#spodko
canvas.create_rectangle(195, 85, 205, 115)
#nos
canvas.create_oval(170, 70, 185, 85)
#oko lave
canvas.create_oval(215, 70, 230, 85)
#oko prave
canvas.create_oval(185, 125, 215, 135)
#usta

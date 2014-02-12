class Bird
  constructor: (scene, @fill='#000000')->
    @x = scene.width * .1
    @y = scene.height * .4
    @height = @width = scene.height / 20
    @ySpeed = thrust

  draw: (ctx)->
    ctx.beginPath()
    ctx.rect @x, @y, @width, @height
    ctx.fillStyle = @fill
    ctx.fill()

  advanceFrame: (time)->
    bird.ySpeed += acceleration * time
    bird.y += bird.ySpeed * time

class Scene
  constructor: (@horizon)->
  draw: (ctx)->
    if not @startTime
      startTime = new Date().getTime()


canvas = document.getElementById 'canvas'
context = canvas.getContext '2d'
horizon = canvas.height * .95
acceleration = 1800 
thrust = -660
started = false
lastTime = 0
bird = new Bird(canvas)

render = ->
  context.clearRect 0, 0, canvas.width, canvas.height
  bird.draw context
  window.requestAnimationFrame render

render()

animateFrame = ->
  thisTime = new Date().getTime()
  time = (thisTime - lastTime) / 1000
  bird.advanceFrame time
  lastTime = thisTime
  if bird.y < horizon
    requestAnimationFrame animateFrame

document.body.addEventListener 'keydown', (e) ->
  if started
    bird.ySpeed = thrust
  else
    started = true
    lastTime = new Date().getTime()
    animateFrame()

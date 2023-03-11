-- 设置游戏窗口大小
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

-- 初始化游戏
function love.load()
    -- 设置窗口标题
    love.window.setTitle("Jump Jump")

    -- 创建玩家对象
    player = {
        x = 0,
        y = WINDOW_HEIGHT - 50,
        width = 50,
        height = 50,
        vy = 0,
        gravity = 1000
    }

    -- 创建平台对象
    platform = {
        x = WINDOW_WIDTH / 2 - 50,
        y = WINDOW_HEIGHT / 2,
        width = 100,
        height = 20
    }
end

-- 更新游戏状态
function love.update(dt)
    -- 处理玩家输入
    if love.keyboard.isDown('space') then
        player.vy = -500
    end

    -- 更新玩家位置
    player.y = player.y + player.vy * dt
    player.vy = player.vy + player.gravity * dt

    -- 检测玩家和平台碰撞
    if checkCollision(player, platform) then
        player.vy = -player.vy
    end

    -- 限制玩家在屏幕内
    if player.y > WINDOW_HEIGHT - player.height then
        player.y = WINDOW_HEIGHT - player.height
        player.vy = 0
    end
end

-- 绘制游戏场景
function love.draw()
    -- 绘制玩家
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)

    -- 绘制平台
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
end

-- 检测两个矩形是否相交
function checkCollision(a, b)
    if a.x + a.width < b.x or a.x > b.x + b.width or a.y + a.height < b.y or a.y > b.y + b.height then
        return false
    else
        return true
    end
end

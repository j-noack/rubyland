
class EnemyAI

    attr_accessor :enemy

    def initialize(enemy)
        @enemy = enemy
        @ratio = 0
    end

    def update
        distance = Math.sqrt(((@enemy.target.x - @enemy.x)**2) + ((@enemy.target.y - @enemy.y)**2))
        if (distance != 0)
            @ratio = @enemy.speed / distance
        end
    end

    def calcNewX
        return @enemy.x + (@enemy.target.x - @enemy.x) * @ratio
    end

    def calcNewY
        return @enemy.y + (@enemy.target.y - @enemy.y) * @ratio
    end
end

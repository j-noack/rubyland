class BattleManager
    def doProjectileCollisionWithBeing(being, projectile)
        being.hp -= projectile.damage

        unless projectile.pierce
            projectile.durability = 0
        else
            projectile.durability -= 1
        end
    end

    def doPlayerCollisionWithEnemy(player, enemy)
        player.hp -= enemy.damage
        if player.hp < 0
            player.hp = 0
        end

        if enemy.kamikaze?
            enemy.hp = 0
        end
    end
end

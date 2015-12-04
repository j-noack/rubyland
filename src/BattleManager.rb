class BattleManager
    def doProjectileCollisionWithBeing(being, projectile)
        being.hp -= projectile.damage
        projectile.duration -= 50
        unless projectile.pierce
            projectile.duration = 0
        end
    end

    def doPlayerCollisionWithEnemy(player, enemy)
        player.hp -= enemy.damage
    end
end

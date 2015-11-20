class BattleManager

    def doProjectileCollisionWithBeing(being, projectile)
        being.hp -= projectile.damage
        projectile.duration = 0
    end

    def doPlayerCollisionWithEnemy(player, enemy)
        player.hp -= enemy.damage
        puts "lala"
    end
end

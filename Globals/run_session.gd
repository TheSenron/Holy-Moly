extends Node

var run_started: bool = false
var run_start_ms: int = 0

var total_coins: int = 0      
var gold: int = 0             


var skill_mole_speed: bool = false          
var skill_worm_boost: bool = false          
var skill_drill_slow: bool = false          
var skill_extra_life: bool = false          
var skill_coin_bonus: bool = false         
# Skill 6 

# Extra-Leben pro Level
var extra_life_used_this_level: bool = false


# ===== Run-Verwaltung =====
func start_new_run() -> void:
    run_started = true
    run_start_ms = Time.get_ticks_msec()
    total_coins = 0
    gold = 0
    _reset_all_skills_runtime()

func reset() -> void:
    run_started = false
    run_start_ms = 0
    total_coins = 0
    gold = 0
    _reset_all_skills_runtime()

func _reset_all_skills_runtime() -> void:
    skill_mole_speed = false
    skill_worm_boost = false
    skill_drill_slow = false
    skill_extra_life = false
    skill_coin_bonus = false

    extra_life_used_this_level = false

func on_new_level_started() -> void:
    extra_life_used_this_level = false


func add_coins(amount: int) -> void:
    total_coins += amount
    gold += amount   


func get_run_time_ms() -> int:
    if not run_started:
        return 0
    return Time.get_ticks_msec() - run_start_ms



func can_afford(cost: int) -> bool:
    return gold >= cost

func buy_skill(cost: int) -> bool:
    if gold >= cost:
        gold -= cost
        return true
    return false


func unlock_skill(skill_id: int) -> void:
    match skill_id:
        1: skill_mole_speed = true
        2: skill_worm_boost = true
        3: skill_drill_slow = true
        4: skill_extra_life = true
        5: skill_coin_bonus = true
        _: pass  # Skill 6 


func mole_speed_multiplier() -> float:
    return 1.1 if skill_mole_speed else 1.0      # +10%

func worm_boost_multiplier() -> float:
    return 1.15 if skill_worm_boost else 1.0     # +15%

func drill_oil_slow_multiplier() -> float:
    return 0.85 if skill_drill_slow else 1.0     # 15 % langsamer

func coin_score_multiplier() -> float:
    return 1.1 if skill_coin_bonus else 1.0      # +10 % mehr Punkte

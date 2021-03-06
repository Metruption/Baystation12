#include "magshield_areas.dm"
#include "magshield.dmm"

/obj/effect/overmap/sector/magshield
	name = "Orbital Magnetic Shield Station"
	desc = "Sensors detect an orbital station above the exoplanet. Sporadic magentic impulses are registred. Planet landing is impossible due to lower orbits being cluttered with chaotically moving metal chunks."
	icon_state = "object"
	known = 0

	generic_waypoints = list(
		"nav_magshield_1",
		"nav_magshield_2",
		"nav_magshield_3",
		"nav_magshield_4",
		"nav_magshield_antag"
	)

/obj/effect/shuttle_landmark/nav_magshield/nav1
	name = "Orbital Station Navpoint #1"
	landmark_tag = "nav_magshield_1"

/obj/effect/shuttle_landmark/nav_magshield/nav2
	name = "Orbital Station Navpoint #2"
	landmark_tag = "nav_magshield_2"

/obj/effect/shuttle_landmark/nav_magshield/nav3
	name = "Orbital Station Navpoint #3"
	landmark_tag = "nav_magshield_3"

/obj/effect/shuttle_landmark/nav_magshield/nav4
	name = "Orbital Station Navpoint #4"
	landmark_tag = "nav_magshield_4"

/obj/effect/shuttle_landmark/nav_magshield/nav5
	name = "Orbital Station Navpoint #5"
	landmark_tag = "nav_magshield_antag"

/obj/structure/magshield/maggen
	name = "magnetic field generator"
	desc = "A large three-handed with rotating top. It is used to create high-power magnetic fields in hard vacuum."
	icon = 'magshield_sprites.dmi'
	icon_state = "maggen"
	var/chance = 0

/obj/structure/magshield/maggen/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/magshield/maggen/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/magshield/maggen/Process()
	var/eye_safety = 0
	chance = rand(1,300)//I wanted to use Poisson distribution with Lambda for 5 minutes but made it simpler
	if (chance == 1)
		empulse(src, 10, 20, 1)
		visible_message("<span class='notice'>\the [src] suddenly activates.</span>", "<span class='notice'>Few lightnings jump between [src]'s rotating hands. You feel everything metal being pulled towards \the [src].</span>")
		for(var/mob/living/carbon/M in hear(10, get_turf(src)))
			eye_safety = M.eyecheck()
			if(eye_safety < FLASH_PROTECTION_MODERATE)
				M.flash_eyes()
				M.Stun(2)

/obj/structure/magshield/rad_sensor
	name = "radiation sensor"
	desc = "Very sensitive vacuum radiation sensor. On top of the metal stand two modified Wilson Cloud Chambers filled with deuterium and tritium water."
	icon = 'magshield_sprites.dmi'
	icon_state = "rad_sensor"
	anchored = 1

/obj/machinery/light/magshield/nav_light
	name = "navigation light"
	desc = "Large and bright light regularly emitting green flashes."
	icon = 'magshield_sprites.dmi'
	icon_state = "nav_light_green"
	brightness_color = "#00ee00"
	brightness_range = 10
	use_power = 0
	idle_power_usage = 0
	active_power_usage = 0
	brightness_power = 10

/obj/machinery/light/magshield/nav_light/red
	desc = "Large and bright light regularly emitting red flashes."
	brightness_color = "#ee0000"
	icon_state = "nav_light_red"


/obj/item/weapon/book/manual/magshield_manual
	name = "SOP for Planetary Shield Orbital Station"
	icon = 'magshield_sprites.dmi'
	icon_state = "mg_guide"
	author = "Terraforms Industrial"
	title = "Standard operating procedures for Planetary Shield Orbital Station"

	dat = {"<html>
				<head>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				h3 {font-size: 13px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				body {font-size: 13px; font-family: Verdana;}
				</style>
				</head>
				<body>

				<h1>Introduction</h1>
				Terraforms Industrial is happy to see you as our customer! Please read this guide before using and operating with your custom PSOS - Planetary Shield Orbital Statiion.
				<h2>Best uses for PSOS</h2>
				PSOS is intended for protecting exoplanets from high energy space radiation rays and particles. Best used for planets lacking active geomagnetic field so PSOS would compensate its absence.<br>
				<h2> Applied technologies</h2>
				Terraforms Industrial is delivering you your new PSOS with set of four (4) high-strength magnetic field generators. Those devices use rotating supeconducter hands to create magnetic field with strength up to 5 Tesla effectively deflecting up to 99% of space radiation spectrum.<br>
				<br>
				Special modified vacuum radiation sensors will help you evaluate radiation level and adjust power input of PSOS magnetic generators for best efficiency and power saving.
				<br><br><br>
				<i>rest of the book pages are gone</i>
				</body>
			</html>
			"}

/obj/item/weapon/paper/magshield/tornpage
	name = "torn book page"
	info = "...you must carefully control radiation sensor automatics during solar flares. Sudden burst of high-energy plasma may cause positive feedback loop and increase magnetic genretors output in order of magnitude. This situation would lead to general damage of unprotected electronic devices as well as trajectory changes in nearby nickel-ferrum astero#&$"

/obj/item/weapon/paper/magshield/log
	name = "printed page"
	info = "\[07:31\] Attention: solar flare detected! Automatic countermeasures activated.<br>\[07:33\] Warning: ERROR: NULL input at FARADAY_CAGE#12.TFI - line 2067: No command found. System will be rebooted.<br>\[07:39\] Warning: radiaton countermeasures inactive. Please initiate emergency protocol.<br>\[07:40\] Warning: radiaton countermeasures inactive. Please initiate emergency protocol.<br>\[07:41\] Warning: radiaton countermeasures inactive. Please initiate emergency protocol.<br>\[07:45\] Attention! Multiple systems failure. Please initiate emergency protocol<br>\[07:52\] Warning: LIDAR-ASTRA system detected multiple meteors approaching. Estimate impact time: 12.478 seconds. <br>\[07:52\] Warning! Miltiple hull breaches det~!!@#"
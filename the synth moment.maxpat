{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 3,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 170.0, 206.0, 1000.0, 810.0 ],
		"gridsize" : [ 15.0, 15.0 ],
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-507",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"orientation" : 1,
					"outlettype" : [ "float", "int" ],
					"patching_rect" : [ 1412.328664422035217, 3526.027140855789185, 325.0, 32.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -52.054790735244751, 204.109574198722839, 221.0, 128.0 ],
					"slidercolor" : [ 0.079348079365577, 0.07934804057877, 0.079348050547289, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-504",
					"maxclass" : "spectroscope~",
					"monochrome" : 0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"orientation" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1417.431074380874634, 3392.045422196388245, 217.0, 89.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 885.507253766059875, 202.898552417755127, 538.0, 130.0 ],
					"range" : [ 0.0, 1.0 ],
					"scroll" : 1,
					"sono" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-502",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 100.568838000297546, 268.05620014667511, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 504.43478661775589, 351.749985098838806, 73.913044095039368, 20.0 ],
					"text" : "MAIN GAIN"
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 1.0, 0.145098039215686, 0.145098039215686, 0.0 ],
					"bubble_outlinecolor" : [ 0.850980392156863, 0.058823529411765, 0.058823529411765, 1.0 ],
					"fontface" : 1,
					"fontsize" : 16.0,
					"id" : "obj-499",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 87.359559535980225, 234.011251211166382, 200.0, 42.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ -25.640452444553375, 795.50568151473999, 151.685405373573303, 42.0 ],
					"text" : "EDWARD JARVIS SYNTHESIZER",
					"textcolor" : [ 0.407843137254902, 0.52156862745098, 0.572549019607843, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-488",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 100.568838000297546, 231.460692644119263, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1.90595555305481, 424.70831835269928, 75.862072944641113, 20.0 ],
					"text" : "AUDIO ON"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-486",
					"maxclass" : "live.scope~",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 3238.043416500091553, 1482.142843008041382, 184.0, 68.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 894.999914646148682, 961.046064674854279, 232.659651756286621, 123.749988198280334 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-485",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 106.854702115058899, 245.011251211166382, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1147.872332215309143, 958.620739936828613, 72.34042501449585, 20.0 ],
					"text" : "Toggle LFO"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-484",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 133.170491337776184, 245.011251211166382, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1343.718075454235077, 971.620739936828613, 60.638297438621521, 20.0 ],
					"text" : "Strength"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-481",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1232.758685350418091, 1016.379363656044006, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1232.703622907400131, 1019.793151378631592, 101.063829779624939, 20.0 ],
					"text" : "Wavetype"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-480",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 83.382030010223389, 261.55620014667511, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1231.691484957933426, 958.620739936828613, 103.191489338874817, 33.0 ],
					"text" : "Tempo alligned frequency (notes)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-478",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 116.853941917419434, 280.657325267791748, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1343.718075454235077, 701.749934315681458, 60.638297438621521, 20.0 ],
					"text" : "Strength"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-476",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 100.568838000297546, 268.05620014667511, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1234.479452759027481, 749.309910893440247, 101.063829779624939, 20.0 ],
					"text" : "Wavetype"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-475",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 105.798525929450989, 324.370810747146606, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1232.446799695491791, 688.749934315681458, 103.191489338874817, 33.0 ],
					"text" : "Tempo alligned frequency (notes)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-474",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 83.382030010223389, 251.44383978843689, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1147.872332215309143, 688.749934315681458, 72.34042501449585, 20.0 ],
					"text" : "Toggle LFO"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-473",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 66.292140126228333, 179.775295257568359, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1.90595555305481, 338.541653752326965, 96.551722526550293, 20.0 ],
					"text" : "PROJECT BPM"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-471",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 116.853941917419434, 238.511251211166382, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1066.938957750797272, 338.541653752326965, 171.276594519615173, 20.0 ],
					"text" : "FILTER FREQUENCY LFOS"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-469",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 66.528096079826355, 261.55620014667511, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1147.872332215309143, 444.961862921714783, 72.34042501449585, 20.0 ],
					"text" : "Toggle LFO"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-467",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 240.685413360595703, 254.814626574516296, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1343.617011666297913, 457.72782027721405, 60.638297438621521, 20.0 ],
					"text" : "Strength"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-465",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 60.854702115058899, 212.011251211166382, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1236.170203924179077, 505.600160360336304, 101.063829779624939, 20.0 ],
					"text" : "Wavetype"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-463",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 59.786522507667542, 234.589905858039856, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1235.106374144554138, 444.961862921714783, 103.191489338874817, 33.0 ],
					"text" : "Tempo alligned frequency (notes)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-459",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 91.247199177742004, 275.039347290992737, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 608.333310127258301, 863.087729096412659, 71.87499725818634, 20.0 ],
					"text" : "Frequency"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-458",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 96.865177154541016, 251.44383978843689, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 841.666634559631348, 863.087729096412659, 18.0, 20.0 ],
					"text" : "Q"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-457",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 334.374987244606018, 644.791642069816589, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 315.445398807525635, 634.541640400886536, 87.499996662139893, 20.0 ],
					"text" : "OSCILATORS"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-455",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 135.067427396774292, 253.691030979156494, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 711.458306193351746, 840.171063303947449, 71.87499725818634, 20.0 ],
					"text" : "HIGHPASS"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-453",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 66.528096079826355, 224.477545499801636, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 712.499972820281982, 594.791643977165222, 69.791664004325867, 20.0 ],
					"text" : "LOWPASS"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-450",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 76.640456438064575, 242.455075025558472, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 844.791634440422058, 612.499976634979248, 18.0, 20.0 ],
					"text" : "Q"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-449",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 191.011251211166382, 233.934494614601135, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 738.791643023490906, 370.833319187164307, 18.0, 20.0 ],
					"text" : "Q"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-446",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 66.292140126228333, 210.338987112045288, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 720.833305835723877, 338.541653752326965, 54.166664600372314, 20.0 ],
					"text" : "NOTCH"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-444",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 70.786522507667542, 219.327751874923706, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 833.854135811328888, 370.833319187164307, 34.374998688697815, 20.0 ],
					"text" : "Gain"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-442",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 137.359559535980225, 245.011251211166382, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 608.333310127258301, 370.833319187164307, 71.87499725818634, 20.0 ],
					"text" : "Frequency"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-441",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 157.539339303970337, 280.657325267791748, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 608.333310127258301, 612.499976634979248, 71.87499725818634, 20.0 ],
					"text" : "Frequency"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-439",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 60.854702115058899, 279.94383978843689, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 362.797592580318451, 338.541653752326965, 44.067797660827637, 20.0 ],
					"text" : "ADSR"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-437",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 137.359559535980225, 244.94383978843689, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 180.794509291648865, 345.249985098838806, 86.516860842704773, 33.0 ],
					"text" : "Note duration (milliseconds)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-435",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 764.406797885894775, 78.813561201095581, 90.0, 22.0 ],
					"text" : "loadmess 2000"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-432",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 610.606980443000793, 78.813561201095581, 50.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 198.876420378684998, 440.44947338104248, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-431",
					"maxclass" : "dial",
					"min" : 1000.0,
					"mult" : 100.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 610.606980443000793, 24.576271772384644, 40.0, 40.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 204.052939713001251, 392.70831835269928, 40.0, 40.0 ],
					"size" : 91.0
				}

			}
, 			{
				"box" : 				{
					"attr" : "domain",
					"id" : "obj-429",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 610.606980443000793, 126.271189451217651, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-425",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1244.565193653106689, 3224.999938488006592, 29.5, 22.0 ],
					"text" : "*~"
				}

			}
, 			{
				"box" : 				{
					"addpoints" : [ 0.0, 0.0, 0, 806.454948922421067, 0.843615613778432, 0, 1833.600879983699087, 0.806834007104238, 0, 2137.0, 0.610847808519999, 0 ],
					"classic_curve" : 1,
					"clickadd" : 0,
					"clicksustain" : 0,
					"domain" : 2137.0,
					"id" : "obj-424",
					"maxclass" : "function",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "float", "", "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 610.606980443000793, 170.338987112045288, 200.0, 100.0 ],
					"pointsize" : 5.72,
					"presentation" : 1,
					"presentation_rect" : [ 284.831491410732269, 384.70831835269928, 200.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-421",
					"maxclass" : "number~",
					"mode" : 2,
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "float" ],
					"patching_rect" : [ 670.940313776334165, 364.772723793983459, 56.0, 22.0 ],
					"sig" : 0.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-391",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 545.352741599082947, 141.525427103042603, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-386",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 671.186456680297852, 303.389837741851807, 34.0, 22.0 ],
					"text" : "line~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-376",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1537.383165657520294, 3093.457919955253601, 61.0, 22.0 ],
					"text" : "comb~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-373",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2051.190456628799438, 1970.238076448440552, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-375",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 2051.190456628799438, 1923.809505462646484, 46.0, 22.0 ],
					"text" : "route 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-372",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1566.666651725769043, 1966.1875, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-370",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 1566.666651725769043, 1920.23807692527771, 46.0, 22.0 ],
					"text" : "route 0"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-366",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2134.523789167404175, 1952.142856121063232, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-368",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 2180.952360153198242, 1871.428553581237793, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[12]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[11]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-365",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1671.875, 1952.38093376159668, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-364",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1671.875, 1845.0, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[8]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[8]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-223",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 3367.857110738754272, 1633.333317756652832, 119.27711284160614, 20.0 ],
					"text" : "heavyness i guess"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-224",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 3254.761873722076416, 1754.761888027191162, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-232",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3126.190446376800537, 1770.238078355789185, 29.5, 22.0 ],
					"text" : "+ 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-233",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 3148.809493780136108, 1578.571413516998291, 94.0, 22.0 ],
					"text" : "scale -1. 1. 0. 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-242",
					"maxclass" : "dial",
					"min" : 20.0,
					"mode" : 5,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 3254.761873722076416, 1615.47617506980896, 71.0, 71.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1338.537224173545837, 993.206945657730103, 71.0, 71.0 ],
					"size" : 3000.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-250",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3148.809493780136108, 1699.999983787536621, 29.5, 22.0 ],
					"text" : "* 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-251",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 2933.333305358886719, 1483.333319187164307, 95.283023297786713, 20.0 ],
					"text" : "toggle lfo on off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-259",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 3048.809494733810425, 1482.142843008041382, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1148.275922298431396, 992.241431355476379, 71.936834931373596, 71.936834931373596 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-260",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 3026.190447330474854, 1632.142841577529907, 103.225807189941406, 22.0 ],
					"text" : "2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-268",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3110.714256048202515, 1521.4285569190979, 81.0, 22.0 ],
					"text" : "snapshot~ 40"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-269",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2841.666639566421509, 1234.523797750473022, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-275",
					"maxclass" : "newobj",
					"numinlets" : 8,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 3101.190446615219116, 1289.285701990127563, 92.5, 22.0 ],
					"text" : "switch 7"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-283",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 3202.380921840667725, 1346.428558588027954, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-285",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 3147.619017601013184, 1346.428558588027954, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-286",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 3101.190446615219116, 1346.428558588027954, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-290",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 3048.809494733810425, 1346.428558588027954, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-292",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 3110.714256048202515, 1444.047605276107788, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-293",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2933.333305358886719, 1349.999987125396729, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1232.703622907400131, 1042.206945657730103, 101.167213439941406, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-296",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3252.380921363830566, 1182.142845869064331, 52.0, 22.0 ],
					"text" : "/ 0.0625"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-300",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 2841.666639566421509, 1182.142845869064331, 29.5, 22.0 ],
					"text" : "+ 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-301",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2841.666639566421509, 1094.047608613967896, 70.0, 22.0 ],
					"text" : "loadmess 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-317",
					"items" : [ "4/1", ",", "2/1", ",", "1/1", ",", "1/2", ",", "1/4", ",", "1/8", ",", "1/16" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2841.666639566421509, 1136.904751062393188, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1233.287229627370834, 993.620739936828613, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-318",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3202.380921840667725, 1182.142845869064331, 45.0, 22.0 ],
					"text" : "/ 0.125"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-320",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3158.333303213119507, 1182.142845869064331, 39.0, 22.0 ],
					"text" : "/ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-321",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3123.809494018554688, 1182.142845869064331, 32.0, 22.0 ],
					"text" : "/ 0.5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-329",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3089.285684823989868, 1182.142845869064331, 29.5, 22.0 ],
					"text" : "/ 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-337",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3054.761875629425049, 1182.142845869064331, 29.5, 22.0 ],
					"text" : "/ 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-339",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3022.619018793106079, 1182.142845869064331, 29.5, 22.0 ],
					"text" : "/ 4."
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-340",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 3136.90473198890686, 1105.952370405197144, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-363",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 3136.90473198890686, 1045.238085269927979, 32.0, 22.0 ],
					"text" : "/ 60."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-30",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 2799.999973297119141, 1644.12442672252655, 119.27711284160614, 20.0 ],
					"text" : "heavyness i guess"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-40",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2686.904736280441284, 1765.55299699306488, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-48",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2558.333308935165405, 1781.029187321662903, 29.5, 22.0 ],
					"text" : "+ 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-114",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2580.952356338500977, 1589.362522482872009, 94.0, 22.0 ],
					"text" : "scale -1. 1. 0. 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-123",
					"maxclass" : "dial",
					"min" : 20.0,
					"mode" : 5,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2686.904736280441284, 1626.267284035682678, 71.0, 71.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1338.537224173545837, 721.861636161804199, 71.0, 71.0 ],
					"size" : 3000.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-156",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2580.952356338500977, 1710.791092753410339, 29.5, 22.0 ],
					"text" : "* 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-157",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 2365.476167917251587, 1494.124428153038025, 95.283023297786713, 20.0 ],
					"text" : "toggle lfo on off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-167",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2480.952357292175293, 1492.9339519739151, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1147.436166107654572, 720.755257546901703, 73.212757229804993, 73.212757229804993 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-169",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2458.333309888839722, 1642.933950543403625, 103.225807189941406, 22.0 ],
					"text" : "1.179453"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-172",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2542.857118606567383, 1532.219665884971619, 81.0, 22.0 ],
					"text" : "snapshot~ 40"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-175",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2273.809502124786377, 1245.314906716346741, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-180",
					"maxclass" : "live.scope~",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 2709.523783683776855, 1500.076809048652649, 184.0, 68.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 894.999914646148682, 688.749934315681458, 232.659651756286621, 123.749988198280334 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-181",
					"maxclass" : "newobj",
					"numinlets" : 8,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2533.333309173583984, 1300.076810956001282, 92.5, 22.0 ],
					"text" : "switch 7"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-182",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2634.523784399032593, 1357.219667553901672, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-183",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2579.761880159378052, 1357.219667553901672, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-185",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2533.333309173583984, 1357.219667553901672, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-186",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2480.952357292175293, 1357.219667553901672, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-187",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2542.857118606567383, 1454.838714241981506, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-188",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2365.476167917251587, 1360.791096091270447, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1232.755314737558365, 770.861636161804199, 102.574459254741669, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-191",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2684.523783922195435, 1192.933954834938049, 52.0, 22.0 ],
					"text" : "/ 0.0625"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-192",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 2273.809502124786377, 1192.933954834938049, 29.5, 22.0 ],
					"text" : "+ 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-193",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2273.809502124786377, 1104.838717579841614, 70.0, 22.0 ],
					"text" : "loadmess 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-194",
					"items" : [ "4/1", ",", "2/1", ",", "1/1", ",", "1/2", ",", "1/4", ",", "1/8", ",", "1/16" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2273.809502124786377, 1147.695860028266907, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1234.042544364929199, 723.749934315681458, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-195",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2634.523784399032593, 1192.933954834938049, 45.0, 22.0 ],
					"text" : "/ 0.125"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-196",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2590.476165771484375, 1192.933954834938049, 39.0, 22.0 ],
					"text" : "/ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-197",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2555.952356576919556, 1192.933954834938049, 32.0, 22.0 ],
					"text" : "/ 0.5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-198",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2521.428547382354736, 1192.933954834938049, 29.5, 22.0 ],
					"text" : "/ 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-205",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2486.904738187789917, 1192.933954834938049, 29.5, 22.0 ],
					"text" : "/ 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-206",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2454.761881351470947, 1192.933954834938049, 29.5, 22.0 ],
					"text" : "/ 4."
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-214",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2569.047594547271729, 1116.743479371070862, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-215",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2569.047594547271729, 1056.029194235801697, 32.0, 22.0 ],
					"text" : "/ 60."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-419",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1315.625, 2025.0, 35.0, 22.0 ],
					"text" : "set 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-418",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1066.625, 1986.747061371803284, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-414",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 1126.506065726280212, 1955.421759009361267, 46.0, 22.0 ],
					"text" : "route 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-412",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 2244.578396201133728, 1644.578374028205872, 119.27711284160614, 20.0 ],
					"text" : "heavyness i guess"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-410",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2131.325379967689514, 1766.265125513076782, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-408",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2003.0, 1781.0, 29.5, 22.0 ],
					"text" : "+ 0."
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-407",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2003.0, 1845.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-405",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2026.0, 1590.0, 94.0, 22.0 ],
					"text" : "scale -1. 1. 0. 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-403",
					"maxclass" : "dial",
					"min" : 20.0,
					"mode" : 5,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2131.325379967689514, 1626.506084203720093, 71.0, 71.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1340.425522327423096, 481.132075428962708, 67.223403692245483, 67.223403692245483 ],
					"size" : 3000.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-402",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2026.0, 1711.0, 29.5, 22.0 ],
					"text" : "* 0."
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-400",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1254.216913819313049, 2325.30129075050354, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-399",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1254.216913819313049, 2261.0625, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[11]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[5]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-398",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1810.483883917331696, 1494.741946160793304, 95.283023297786713, 20.0 ],
					"text" : "toggle lfo on off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-396",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1925.508078336715698, 1492.741946160793304, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1147.88571172952652, 479.443327367305756, 72.313665986061096, 72.313665986061096 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-394",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1903.614528179168701, 1643.373554706573486, 103.225807189941406, 22.0 ],
					"text" : "1.5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-392",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 1987.766143441200256, 1532.258075475692749, 81.0, 22.0 ],
					"text" : "snapshot~ 40"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-390",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1718.548399388790131, 1245.161299228668213, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-383",
					"maxclass" : "live.scope~",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 2154.838725090026855, 1500.00001072883606, 184.0, 68.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 894.680844664573669, 444.961862921714783, 232.978721737861633, 127.659573554992676 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-374",
					"maxclass" : "newobj",
					"numinlets" : 8,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1978.461727142333984, 1300.000123977661133, 92.5, 22.0 ],
					"text" : "switch 7"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-341",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2079.032272934913635, 1357.258074223995209, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-342",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 2024.516143441200256, 1357.258074223995209, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-343",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1978.461727142333984, 1357.258074223995209, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-344",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1925.508078336715698, 1357.258074223995209, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-361",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1987.766143441200256, 1454.838720083236694, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-362",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1810.483883917331696, 1361.290332317352295, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1236.170203924179077, 526.876755952835083, 99.468085110187531, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-335",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2129.032273292541504, 1192.741944015026093, 52.0, 22.0 ],
					"text" : "/ 0.0625"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-333",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1718.548399388790131, 1192.741944015026093, 29.5, 22.0 ],
					"text" : "+ 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-319",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1718.548399388790131, 1104.838717579841614, 70.0, 22.0 ],
					"text" : "loadmess 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-316",
					"items" : [ "4/1", ",", "2/1", ",", "1/1", ",", "1/2", ",", "1/4", ",", "1/8", ",", "1/16" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1718.548399388790131, 1147.580653369426727, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1236.170203924179077, 480.068245649337769, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-315",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2079.032272934913635, 1192.741944015026093, 45.0, 22.0 ],
					"text" : "/ 0.125"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-314",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2035.822594881057739, 1192.741944015026093, 39.0, 22.0 ],
					"text" : "/ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-313",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2000.806465923786163, 1192.741944015026093, 32.0, 22.0 ],
					"text" : "/ 0.5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-305",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 1966.129046320915222, 1192.741944015026093, 29.5, 22.0 ],
					"text" : "/ 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-304",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 1932.258078336715698, 1192.741944015026093, 29.5, 22.0 ],
					"text" : "/ 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-303",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 1899.193561971187592, 1192.741944015026093, 29.5, 22.0 ],
					"text" : "/ 4."
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-302",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2014.516143441200256, 1116.935491859912872, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-299",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 2014.516143441200256, 1056.45162045955658, 32.0, 22.0 ],
					"text" : "/ 60."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-298",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 2113.709692537784576, 908.870974242687225, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-297",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2113.709692537784576, 966.935490787029266, 29.5, 22.0 ],
					"text" : "120"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-294",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2014.516143441200256, 1003.225813627243042, 50.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1.90595555305481, 378.260872721672058, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-284",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 435.245889186859131, 2016.39338493347168, 150.0, 33.0 ],
					"text" : "dk wht was going on here lol"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-282",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1382.4375, 2962.5, 60.0, 22.0 ],
					"text" : "cascade~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-280",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1423.4375, 2696.875, 101.0, 22.0 ],
					"text" : "prepend cascade"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-279",
					"maxclass" : "newobj",
					"numinlets" : 15,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1423.4375, 2646.875, 166.0, 22.0 ],
					"text" : "pak f f f f f f f f f f f f f f f"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-278",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2089.0625, 2300.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-190",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1606.25, 2289.0625, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-189",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1165.625, 2317.1875, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"id" : "obj-184",
					"maxclass" : "filtergraph~",
					"nfilters" : 3,
					"numinlets" : 8,
					"numoutlets" : 7,
					"outlettype" : [ "list", "float", "float", "float", "float", "list", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1423.4375, 2762.5, 256.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 598.550729632377625, 204.347827792167664, 288.405799508094788, 127.536232948303223 ],
					"setfilter" : [ 2, 0, 1, 0, 0, 90.0, 1.0, 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 1, 0, 0, 60.0, 1.0, 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 20000.0, 1.803223490715027, 0.995770573616028, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ],
					"style" : "chiba"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-179",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2121.875, 2029.6875, 35.0, 22.0 ],
					"text" : "set 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-178",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1642.1875, 2029.6875, 35.0, 22.0 ],
					"text" : "set 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-177",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1964.0625, 2056.25, 35.0, 22.0 ],
					"text" : "set 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-176",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1485.9375, 2051.5625, 61.0, 22.0 ],
					"text" : "set 20000"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-174",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1195.3125, 2025.0, 35.0, 22.0 ],
					"text" : "set 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-173",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1040.625, 2051.5625, 35.0, 22.0 ],
					"text" : "set 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-171",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 1393.75, 1967.1875, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_mode",
					"id" : "obj-170",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1820.3125, 2314.0625, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_mode",
					"id" : "obj-168",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1571.875, 2340.625, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-158",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 2042.1875, 2185.9375, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-159",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2118.75, 2142.1875, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-160",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 2118.75, 2075.0, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 824.999968528747559, 884.962728261947632, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 2.0,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[9]",
							"parameter_mmax" : 10.0,
							"parameter_mmin" : 0.5,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 1
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[9]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_Q",
					"id" : "obj-161",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 2118.75, 2185.9375, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-162",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1889.0625, 2221.875, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-163",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1964.0625, 2185.9375, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-164",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1964.0625, 2121.875, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 618.749976396560669, 884.962728261947632, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[10]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[10]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-165",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1964.0625, 2221.875, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"id" : "obj-166",
					"maxclass" : "filtergraph~",
					"nfilters" : 1,
					"numinlets" : 8,
					"numoutlets" : 7,
					"outlettype" : [ "list", "float", "float", "float", "float", "list", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1964.0625, 2398.4375, 256.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 619.791643023490906, 958.921058773994446, 256.0, 128.0 ],
					"setfilter" : [ 0, 2, 1, 0, 0, 0.000099999997474, 1.045223832130432, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ],
					"style" : "chiba"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-139",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1567.1875, 2179.6875, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-141",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1642.1875, 2135.9375, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-143",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1642.1875, 2068.75, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 826.041635155677795, 634.374975800514221, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 2.0,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[6]",
							"parameter_mmax" : 10.0,
							"parameter_mmin" : 0.5,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 1
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[6]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_Q",
					"id" : "obj-145",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1642.1875, 2179.6875, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-149",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1412.5, 2217.1875, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-151",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1485.9375, 2179.6875, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-153",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1485.9375, 2117.1875, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 619.791643023490906, 634.374975800514221, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[7]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[7]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-154",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1485.9375, 2217.1875, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"id" : "obj-155",
					"maxclass" : "filtergraph~",
					"nfilters" : 1,
					"numinlets" : 8,
					"numoutlets" : 7,
					"outlettype" : [ "list", "float", "float", "float", "float", "list", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1453.773468792438507, 2392.452639102935791, 256.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 619.791643023490906, 688.541640400886536, 256.0, 128.0 ],
					"setfilter" : [ 0, 1, 1, 0, 0, 13281.708984375, 1.082006096839905, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ],
					"style" : "chiba"
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-147",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1315.625, 2085.9375, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 826.041635155677795, 392.70831835269928, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 2.0,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[4]",
							"parameter_mmax" : 10.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 1
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[4]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_amp",
					"id" : "obj-136",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1231.25, 2223.4375, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-63",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1118.75, 2187.5, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-79",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1195.3125, 2143.75, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-88",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1195.3125, 2076.5625, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 722.916639089584351, 392.70831835269928, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 2.0,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[3]",
							"parameter_mmax" : 10.0,
							"parameter_mmin" : 0.5,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 1
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[3]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_Q",
					"id" : "obj-105",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1195.3125, 2187.5, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-115",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 967.1875, 2223.4375, 72.0, 22.0 ],
					"text" : "prepend set"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-106",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1040.625, 2187.5, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-97",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1040.625, 2123.4375, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 619.791643023490906, 392.70831835269928, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[2]",
							"parameter_mmax" : 20000.0,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[2]"
				}

			}
, 			{
				"box" : 				{
					"attr" : "edit_freq",
					"id" : "obj-96",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1040.625, 2223.4375, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"id" : "obj-38",
					"maxclass" : "filtergraph~",
					"nfilters" : 1,
					"numinlets" : 8,
					"numoutlets" : 7,
					"outlettype" : [ "list", "float", "float", "float", "float", "list", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1031.192574501037598, 2405.633834362030029, 256.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 619.791643023490906, 444.791649699211121, 256.0, 128.0 ],
					"setfilter" : [ 0, 5, 1, 0, 0, 0.000099999997474, 0.000099999997474, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ],
					"style" : "chiba"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-152",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 842.25353217124939, 2042.25354790687561, 91.346156895160675, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ -40.591112613677979, 988.896533250808716, 91.346156895160675, 33.0 ],
					"text" : "Pitch shift compensation"
				}

			}
, 			{
				"box" : 				{
					"attr" : "quality",
					"id" : "obj-150",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 642.25352954864502, 2298.591579437255859, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-148",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 802.816911935806274, 2032.394392848014832, 29.5, 22.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-146",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 791.549306154251099, 1935.21129298210144, 44.576920092105865, 20.0 ],
					"text" : "Reset"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-144",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 802.816911935806274, 1977.46481466293335, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"attr" : "pitchshiftcent",
					"id" : "obj-142",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 801.408461213111877, 2343.662002563476562, 150.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-140",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 801.408461213111877, 2288.732424378395081, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-138",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 900.000011801719666, 2101.408478260040283, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-137",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 829.577475666999817, 2156.338056445121765, 29.5, 22.0 ],
					"text" : "200"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-135",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"patching_rect" : [ 801.408461213111877, 2238.02819836139679, 40.0, 22.0 ],
					"text" : "line"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-133",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 801.408461213111877, 2192.957775235176086, 47.0, 22.0 ],
					"text" : "pack f f"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-132",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 802.816911935806274, 2084.50706958770752, 86.538464426994324, 48.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -37.466112732887268, 1032.646531581878662, 86.538464426994324, 48.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ 0 ],
							"parameter_initial_enable" : 1,
							"parameter_linknames" : 1,
							"parameter_longname" : "Transp",
							"parameter_mmax" : 0.0,
							"parameter_mmin" : -2400.0,
							"parameter_modmode" : 0,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "Transp",
							"parameter_type" : 0,
							"parameter_units" : "cent",
							"parameter_unitstyle" : 9
						}

					}
,
					"varname" : "Transp"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-124",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 628.16902232170105, 2405.633834362030029, 63.0, 22.0 ],
					"text" : "pitchshift~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1323.853100538253784, 3065.21733283996582, 34.0, 22.0 ],
					"text" : "limi~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-34",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "multichannelsignal" ],
					"patching_rect" : [ 192.771091461181641, 2719.277208924293518, 92.0, 22.0 ],
					"text" : "mc.mixdown~ 3"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-87",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 535.0, 1962.5, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-78",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1309.853100538253784, 3392.045422196388245, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 517.391308665275574, 384.94947338104248, 48.0, 133.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_longname" : "live.gain~[1]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~[1]",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[16]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-64",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 86.5, 2050.0, 105.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -46.841112375259399, 902.43820321559906, 105.0, 20.0 ],
					"text" : "Modulation toggle"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-62",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 53.0, 2107.0, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-61",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 167.0, 2147.0, 29.5, 22.0 ],
					"text" : "+ 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-58",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 127.0, 2078.0, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -18.716113448143005, 931.604868769645691, 47.692312240600586, 47.692312240600586 ],
					"svg" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-56",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 189.156633496284485, 2231.32538366317749, 49.0, 22.0 ],
					"text" : "gate~ 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-54",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 628.16902232170105, 2209.85918390750885, 29.5, 22.0 ],
					"text" : "*~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-42",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 489.0, 1962.5, 29.5, 22.0 ],
					"text" : "50"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-44",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 361.5, 1968.0, 34.0, 22.0 ],
					"text" : "line~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-46",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 435.0, 1962.5, 50.0, 35.0 ],
					"text" : "4.448913"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-50",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 673.0, 1957.0, 77.477477431297302, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 78.158882856369019, 901.396536588668823, 77.477477431297302, 33.0 ],
					"text" : "Modulation Wave"
				}

			}
, 			{
				"box" : 				{
					"appearance" : 3,
					"id" : "obj-52",
					"maxclass" : "live.dial",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 607.0, 1947.5, 50.0, 52.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 92.742215633392334, 1007.646532535552979, 50.0, 52.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_enum" : [ "0", "20000" ],
							"parameter_exponent" : 3.5,
							"parameter_initial" : [ 0.0 ],
							"parameter_longname" : "live.dial[1]",
							"parameter_mmax" : 5000.0,
							"parameter_mmin" : 0.1,
							"parameter_modmax" : 20000.0,
							"parameter_modmode" : 4,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.dial",
							"parameter_steps" : 14950,
							"parameter_type" : 0,
							"parameter_unitstyle" : 3
						}

					}
,
					"showname" : 0,
					"varname" : "live.dial[1]"
				}

			}
, 			{
				"box" : 				{
					"automatic" : 1,
					"id" : "obj-36",
					"maxclass" : "scope~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 1417.431074380874634, 3229.357528686523438, 217.0, 127.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 166.666668057441711, 204.347827792167664, 432.209784269332886, 127.536232948303223 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 395.0, 2155.0, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 383.0, 2133.0, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 368.0, 2108.0, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 357.0, 2084.0, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 347.0, 2248.0, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-28",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 435.0, 2055.0, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 78.158882856369019, 945.14653491973877, 77.477477431297302, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-71",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 1257.580373764038086, 3526.136330008506775, 45.0, 45.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 4.40595555305481, 463.768119812011719, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "kslider",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "int", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 150.568838000297546, 496.111418962478638, 336.0, 53.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 216.831491410732269, 550.818161368370056, 336.0, 53.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "int", "int" ],
					"patching_rect" : [ 217.960148453712463, 415.676629066467285, 41.0, 22.0 ],
					"text" : "notein"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1123.287589550018311, 1539.143835783004761, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 4221.917501211166382, 3967.12299919128418, 150.0, 20.0 ],
					"text" : "big"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-369",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1008.316917538642883, 757.280907154083252, 150.0, 33.0 ],
					"text" : "retriggers calc (slang for calculator)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-367",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 970.602734446525574, 757.280907154083252, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-360",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 779.441728711128235, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 16."
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-352",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1051.708684086799622, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-353",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 998.318852305412292, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-354",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 946.62393581867218, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-355",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 894.929019331932068, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-356",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 842.386645197868347, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-357",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 789.844271063804626, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-358",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 738.149354577064514, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-359",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 685.606980443000793, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-348",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 633.912063956260681, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-349",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 580.522232174873352, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-350",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 528.82731568813324, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-351",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 477.132399201393127, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-347",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 425.437482714653015, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-346",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 372.047650933265686, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-345",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 320.352734446525574, 687.077524900436401, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-338",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 544.34850811958313, 410.958874225616455, 73.728815317153931, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -41.818180322647095, 581.818161368370056, 67.123282790184021, 20.0 ],
					"text" : "Reset to 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-336",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 569.212915778160095, 438.619891881942749, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.181816816329956, 579.818161368370056, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-334",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 601.102734446525574, 476.47582483291626, 29.5, 22.0 ],
					"text" : "1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-332",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 638.601295590400696, 439.619891881942749, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"floatoutput" : 1,
					"id" : "obj-331",
					"maxclass" : "dial",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 647.601295590400696, 509.111418962478638, 40.0, 40.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 85.561916649341583, 571.818161368370056, 40.0, 40.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ 1.0 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "dial[1]",
							"parameter_mmax" : 2.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "dial",
							"parameter_steps" : 1000,
							"parameter_type" : 0
						}

					}
,
					"size" : 2.0,
					"varname" : "dial"
				}

			}
, 			{
				"box" : 				{
					"cantchange" : 1,
					"format" : 6,
					"id" : "obj-330",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 647.601295590400696, 576.90803074836731, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-322",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 750.602734446525574, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 15."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-323",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 718.602734446525574, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 14."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-324",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 686.602734446525574, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 13."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-325",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 655.712912201881409, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 12."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-326",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 623.50952160358429, 628.602947235107422, 32.0, 22.0 ],
					"text" : "* 11."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-327",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 592.153588652610779, 628.602947235107422, 33.0, 22.0 ],
					"text" : "* 10."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-328",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 559.95019805431366, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 9."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-309",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 528.594265103340149, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 8."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-310",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 498.085789799690247, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 7."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-311",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 466.729856848716736, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 6."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-312",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 435.373923897743225, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 5."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-307",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 404.017990946769714, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 4."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-308",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 372.662057995796204, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 3."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-306",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 341.306125044822693, 628.602947235107422, 29.5, 22.0 ],
					"text" : "* 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-295",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 716.66663932800293, 501.123635530471802, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 39.583331823348999, 529.999981045722961, 116.053028464317322, 33.0 ],
					"text" : "overtone coefficient (standard is 1)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-291",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 154.031307816505432, 1244.995213747024536, 29.5, 22.0 ],
					"text" : "-70."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-289",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 136.031307101249695, 1166.423783302307129, 60.000001430511475, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 14.606742739677429, 718.43830406665802, 71.186442375183105, 20.0 ],
					"text" : "Reset gain"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-287",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 154.031307816505432, 1202.138069868087769, 24.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 38.202250242233276, 752.809048891067505, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-281",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 199.999985456466675, 1991.198597431182861, 34.0, 22.0 ],
					"text" : "limi~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-277",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "multichannelsignal" ],
					"patching_rect" : [ 199.999985456466675, 1926.815040469169617, 99.0, 22.0 ],
					"text" : "mc.mixdown~ 16"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-276",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 97.602735638618469, 854.00315248966217, 29.5, 22.0 ],
					"text" : "1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-274",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 106.854702115058899, 790.11426055431366, 58.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-273",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 128.602734446525574, 904.280907154083252, 45.669293761253357, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 27.347169935703278, 634.541640400886536, 45.669293761253357, 20.0 ],
					"text" : "set all "
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-271",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 79.689348995685577, 929.280907154083252, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 0.181816816329956, 673.563207149505615, 100.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-199",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1458.904003500938416, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 537.931025505065918, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[30]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[8]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-200",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1508.21906840801239, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-201",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1497.260165095329285, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-202",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1483.561535954475403, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-203",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1472.602632641792297, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-204",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1458.904003500938416, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-207",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1369.862914085388184, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 544.827577114105225, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-208",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1272.602647185325623, 1643.253417253494263, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 483.041074872016907, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[25]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[9]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-209",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1319.177986264228821, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-210",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1308.219082951545715, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-211",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1294.520453810691833, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-212",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1283.561550498008728, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-213",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1272.602647185325623, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-216",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1179.451969027519226, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 489.937626481056213, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-217",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1090.410879611968994, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 433.041074872016907, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[22]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[10]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-218",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1136.986218690872192, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-219",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1126.027315378189087, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-220",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1112.328686237335205, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-221",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1101.3697829246521, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-222",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1090.410879611968994, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-225",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 997.260201454162598, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 438.788201212882996, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-226",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 901.369797468185425, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 385.057466506958008, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[26]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[11]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-227",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 947.945136547088623, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-228",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 936.986233234405518, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-229",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 923.287604093551636, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-230",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 912.32870078086853, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-231",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 901.369797468185425, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-234",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 808.219119310379028, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 391.954018115997314, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-235",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 708.219126582145691, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 335.057466506958008, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[20]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[12]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-236",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 758.904054403305054, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-237",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 747.945151090621948, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-238",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 734.246521949768066, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-239",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 723.287618637084961, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-240",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 708.219126582145691, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-241",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 687.671182870864868, 1447.363020539283752, 29.5, 22.0 ],
					"text" : "1"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-243",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 619.178037166595459, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 341.954018115997314, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-244",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 523.287633180618286, 1643.253417253494263, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 285.057466506958008, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[17]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[13]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-245",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 571.232835173606873, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-246",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 558.904068946838379, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-247",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 547.945165634155273, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-248",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 534.246536493301392, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-249",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 523.287633180618286, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-252",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 430.13695502281189, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 290.804592847824097, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-253",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 341.095865607261658, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 230.794509291648865, 950.921058773994446, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[21]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[14]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-254",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 389.041067600250244, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-255",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 376.71230137348175, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-256",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 361.64380931854248, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-257",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 352.054768919944763, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-258",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 341.095865607261658, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-261",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 247.945187449455261, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 237.691060900688171, 907.24289858341217, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-262",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 152.054783463478088, 1647.363005995750427, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 180.794509291648865, 950.684862375259399, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[23]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[15]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-263",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 199.999985456466675, 1465.171238422393799, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-264",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 187.671219229698181, 1443.253431797027588, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-265",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 172.602727174758911, 1418.595899343490601, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-266",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 161.643823862075806, 1393.938366889953613, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-267",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 152.054783463478088, 1558.321916580200195, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-270",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 58.904105305671692, 1489.828770875930786, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 187.553130269050598, 906.896536588668823, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-99",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1567.840665698051453, 1181.661831855773926, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 537.931025505065918, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[28]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[4]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-100",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1616.650184154510498, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-101",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1604.745423555374146, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-102",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1591.650186896324158, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-103",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1579.745426297187805, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-104",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1567.840665698051453, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-107",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1476.174009084701538, 1026.899944067001343, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 544.827577114105225, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-108",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1379.745448231697083, 1180.471355795860291, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 483.041074872016907, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[27]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[5]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-109",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1428.554966688156128, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-110",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1415.45973002910614, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-111",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1403.554969429969788, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-112",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1391.650208830833435, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-113",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1379.745448231697083, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-116",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1286.888315558433533, 1025.709468007087708, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 489.937626481056213, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-117",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1197.602611064910889, 1181.661831855773926, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 433.041074872016907, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[24]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[6]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-118",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1246.412129521369934, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-119",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1234.507368922233582, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-120",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1221.412132263183594, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-121",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1209.507371664047241, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-122",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1197.602611064910889, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-125",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1105.935954451560974, 1026.899944067001343, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 438.788201212882996, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-126",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 1008.316917538642883, 1181.661831855773926, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 385.057466506958008, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[16]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[7]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-127",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1057.126435995101929, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-128",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1045.221675395965576, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-129",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1032.126438736915588, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-130",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1020.221678137779236, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-131",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 1008.316917538642883, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-134",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 916.650260925292969, 1026.899944067001343, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 391.954018115997314, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-81",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 818.697946429252625, 1181.661831855773926, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 335.057466506958008, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[18]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[2]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-82",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 867.50746488571167, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-83",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 855.602704286575317, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-84",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 842.50746762752533, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-85",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 830.602707028388977, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-86",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 818.697946429252625, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-89",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 727.03128981590271, 1026.899944067001343, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 341.954018115997314, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-90",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 630.602728962898254, 1180.471355795860291, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 285.057466506958008, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[19]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[3]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-91",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 679.4122474193573, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-92",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 666.317010760307312, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-93",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 654.412250161170959, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-94",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 642.507489562034607, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-95",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 630.602728962898254, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-98",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 537.745596289634705, 1025.709468007087708, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 290.804592847824097, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-72",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 447.602693319320679, 1181.661831855773926, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 230.794509291648865, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_initial" : [ -70 ],
							"parameter_initial_enable" : 1,
							"parameter_longname" : "live.gain~[29]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~[1]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-73",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 496.412211775779724, 1001.899946808815002, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-74",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 484.352693319320679, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-75",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 471.412214517593384, 953.090428352355957, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-76",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 459.507453918457031, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-77",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 447.602693319320679, 1092.376127362251282, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-80",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 355.936036705970764, 1026.899944067001343, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 237.691060900688171, 673.909569144248962, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-70",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 259.0, 1181.0, 48.0, 136.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 180.794509291648865, 716.43830406665802, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_longname" : "live.gain~[31]",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_modmode" : 3,
							"parameter_osc_name" : "<default>",
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-69",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 307.602734446525574, 1002.280907154083252, 40.0, 22.0 ],
					"text" : "rect~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-68",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 295.352734446525574, 978.090425610542297, 40.0, 22.0 ],
					"text" : "tri~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-67",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 283.102734446525574, 953.280907154083252, 37.0, 22.0 ],
					"text" : "saw~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-66",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 270.852734446525574, 929.280907154083252, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-65",
					"maxclass" : "newobj",
					"numinlets" : 5,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 258.602734446525574, 1092.280907154083252, 68.0, 22.0 ],
					"text" : "selector~ 4"
				}

			}
, 			{
				"box" : 				{
					"allowdrag" : 0,
					"id" : "obj-60",
					"items" : [ "None", "Selected", ",", "Sine", ",", "Sawtooth", ",", "Triangle", ",", "Square" ],
					"maxclass" : "umenu",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 166.650343179702759, 1026.423692226409912, 100.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 187.553130269050598, 673.563207149505615, 34.482758045196533, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-59",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1048.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-57",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 996.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-55",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 944.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-53",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 892.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-51",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 840.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-49",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 788.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-47",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 736.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-45",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 684.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-43",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 632.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-41",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 580.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-39",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 528.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-37",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 476.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-35",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 424.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-33",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 319.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-31",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 371.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-29",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 267.602734446525574, 848.280907154083252, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 738.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 16."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 707.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 15."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 675.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 14."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 644.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 13."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 612.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 12."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 581.602734446525574, 758.280907154083252, 32.0, 22.0 ],
					"text" : "* 11."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 549.602734446525574, 758.280907154083252, 33.0, 22.0 ],
					"text" : "* 10."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 518.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 9."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 487.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 8."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 455.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 7."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 424.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 6."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 393.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 5."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 361.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 4."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 330.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 3."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 298.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 2."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 267.602734446525574, 758.280907154083252, 29.5, 22.0 ],
					"text" : "* 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 267.602734446525574, 712.280907154083252, 32.0, 22.0 ],
					"text" : "mtof"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 150.568838000297546, 655.289388418197632, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 3667.605681896209717, 3938.028220653533936, 150.0, 20.0 ],
					"text" : "bigger"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.117647058823529, 0.117647058823529, 0.258823529411765, 1.0 ],
					"id" : "obj-495",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 94.382030010223389, 191.011251211166382, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -51.685397386550903, 878.651755571365356, 226.966310262680054, 243.820244193077087 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.611764705882353, 0.580392156862745, 0.16078431372549, 1.0 ],
					"id" : "obj-494",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 94.382030010223389, 197.44383978843689, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -51.685397386550903, 624.719151020050049, 650.5618497133255, 497.752848744392395 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"grad1" : [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
					"grad2" : [ 0.396078431372549, 0.396078431372549, 0.396078431372549, 1.0 ],
					"id" : "obj-493",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 66.528096079826355, 181.78091287612915, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ -51.685397386550903, 333.707891821861267, 217.977545499801636, 788.764107942581177 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.517647058823529, 0.411764705882353, 0.694117647058824, 1.0 ],
					"id" : "obj-496",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 94.382030010223389, 191.011251211166382, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 153.932596564292908, 333.707891821861267, 444.943855762481689, 298.792084813117981 ],
					"proportion" : 0.5
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.0, 0.549019607843137, 0.67843137254902, 1.0 ],
					"id" : "obj-497",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 82.854702115058899, 191.011251211166382, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 591.011283159255981, 333.707891821861267, 295.505641579627991, 788.764107942581177 ],
					"proportion" : 0.5,
					"saved_attribute_attributes" : 					{
						"bgfillcolor" : 						{
							"expression" : "themecolor.live_modulation"
						}

					}

				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"bgcolor" : [ 0.109803921568627, 0.368627450980392, 0.0, 1.0 ],
					"id" : "obj-500",
					"maxclass" : "panel",
					"mode" : 0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 137.359559535980225, 149.94383978843689, 128.0, 128.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 882.474177360534668, 334.020599842071533, 540.206155300140381, 788.659749627113342 ],
					"proportion" : 0.5
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 4 ],
					"midpoints" : [ 404.5, 2244.0, 405.5, 2244.0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-31", 0 ],
					"midpoints" : [ 340.102734446525574, 834.0, 381.102734446525574, 834.0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 4 ],
					"midpoints" : [ 1626.150184154510498, 1026.0, 1626.340665698051453, 1026.0 ],
					"source" : [ "obj-100", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 3 ],
					"midpoints" : [ 1614.245423555374146, 1002.0, 1611.0, 1002.0, 1611.0, 1089.0, 1614.090665698051453, 1089.0 ],
					"source" : [ "obj-101", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 2 ],
					"midpoints" : [ 1601.150186896324158, 978.0, 1601.840665698051453, 978.0 ],
					"source" : [ "obj-102", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 1 ],
					"midpoints" : [ 1589.245426297187805, 954.0, 1589.590665698051453, 954.0 ],
					"source" : [ "obj-103", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-99", 1 ],
					"midpoints" : [ 1577.340665698051453, 1167.0, 1606.340665698051453, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-104", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-99", 0 ],
					"midpoints" : [ 1577.340665698051453, 1116.0, 1577.340665698051453, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-104", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"midpoints" : [ 1204.8125, 2391.0, 1040.692574501037598, 2391.0 ],
					"source" : [ "obj-105", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-115", 0 ],
					"midpoints" : [ 1050.125, 2211.0, 976.6875, 2211.0 ],
					"order" : 1,
					"source" : [ "obj-106", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-96", 0 ],
					"midpoints" : [ 1050.125, 2211.0, 1050.125, 2211.0 ],
					"order" : 0,
					"source" : [ "obj-106", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 0 ],
					"midpoints" : [ 1485.674009084701538, 1077.0, 1577.340665698051453, 1077.0 ],
					"source" : [ "obj-107", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1396.495448231697083, 1621.643198132514954, 209.499985456466675, 1621.643198132514954 ],
					"source" : [ "obj-108", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1389.245448231697083, 1621.643198132514954, 209.499985456466675, 1621.643198132514954 ],
					"source" : [ "obj-108", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 4 ],
					"midpoints" : [ 1438.054966688156128, 1026.0, 1438.245448231697083, 1026.0 ],
					"source" : [ "obj-109", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 0 ],
					"midpoints" : [ 371.102734446525574, 834.0, 434.102734446525574, 834.0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 3 ],
					"midpoints" : [ 1424.95973002910614, 1089.0, 1425.995448231697083, 1089.0 ],
					"source" : [ "obj-110", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 2 ],
					"midpoints" : [ 1413.054969429969788, 993.0, 1410.0, 993.0, 1410.0, 1089.0, 1413.745448231697083, 1089.0 ],
					"source" : [ "obj-111", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 1 ],
					"midpoints" : [ 1401.150208830833435, 954.0, 1329.0, 954.0, 1329.0, 1005.0, 1401.495448231697083, 1005.0 ],
					"source" : [ "obj-112", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-108", 1 ],
					"midpoints" : [ 1389.245448231697083, 1167.0, 1418.245448231697083, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-113", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-108", 0 ],
					"midpoints" : [ 1389.245448231697083, 1116.0, 1389.245448231697083, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-113", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-156", 0 ],
					"midpoints" : [ 2590.452356338500977, 1614.0, 2590.452356338500977, 1614.0 ],
					"order" : 0,
					"source" : [ "obj-114", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-169", 1 ],
					"midpoints" : [ 2590.452356338500977, 1629.0, 2552.059117078781128, 1629.0 ],
					"order" : 1,
					"source" : [ "obj-114", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-97", 0 ],
					"midpoints" : [ 976.6875, 2247.0, 954.0, 2247.0, 954.0, 2133.0, 1026.0, 2133.0, 1026.0, 2118.0, 1050.125, 2118.0 ],
					"source" : [ "obj-115", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 0 ],
					"midpoints" : [ 1296.388315558433533, 1077.0, 1389.245448231697083, 1077.0 ],
					"source" : [ "obj-116", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1214.352611064910889, 1622.238436162471771, 209.499985456466675, 1622.238436162471771 ],
					"source" : [ "obj-117", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1207.102611064910889, 1622.238436162471771, 209.499985456466675, 1622.238436162471771 ],
					"source" : [ "obj-117", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 4 ],
					"midpoints" : [ 1255.912129521369934, 1026.0, 1256.102611064910889, 1026.0 ],
					"source" : [ "obj-118", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 3 ],
					"midpoints" : [ 1244.007368922233582, 1002.0, 1218.0, 1002.0, 1218.0, 1077.0, 1243.852611064910889, 1077.0 ],
					"source" : [ "obj-119", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-37", 0 ],
					"midpoints" : [ 403.102734446525574, 834.0, 486.102734446525574, 834.0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 2 ],
					"midpoints" : [ 1230.912132263183594, 1002.0, 1218.0, 1002.0, 1218.0, 1077.0, 1231.602611064910889, 1077.0 ],
					"source" : [ "obj-120", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 1 ],
					"midpoints" : [ 1219.007371664047241, 954.0, 1194.0, 954.0, 1194.0, 945.0, 1134.0, 945.0, 1134.0, 1011.0, 1219.352611064910889, 1011.0 ],
					"source" : [ "obj-121", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-117", 1 ],
					"midpoints" : [ 1207.102611064910889, 1167.0, 1236.102611064910889, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-122", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-117", 0 ],
					"midpoints" : [ 1207.102611064910889, 1116.0, 1207.102611064910889, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-122", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-156", 1 ],
					"midpoints" : [ 2696.404736280441284, 1707.0, 2600.952356338500977, 1707.0 ],
					"order" : 1,
					"source" : [ "obj-123", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-40", 0 ],
					"midpoints" : [ 2696.404736280441284, 1698.0, 2696.404736280441284, 1698.0 ],
					"order" : 0,
					"source" : [ "obj-123", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"midpoints" : [ 637.66902232170105, 2706.0, 202.271091461181641, 2706.0 ],
					"source" : [ "obj-124", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 0 ],
					"midpoints" : [ 1115.435954451560974, 1077.0, 1207.102611064910889, 1077.0 ],
					"source" : [ "obj-125", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1025.066917538642883, 1476.0, 987.0, 1476.0, 987.0, 1497.0, 981.0, 1497.0, 981.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-126", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1017.816917538642883, 1476.0, 987.0, 1476.0, 987.0, 1497.0, 981.0, 1497.0, 981.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-126", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 4 ],
					"midpoints" : [ 1066.626435995101929, 1026.0, 1066.816917538642883, 1026.0 ],
					"source" : [ "obj-127", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 3 ],
					"midpoints" : [ 1054.721675395965576, 1002.0, 1054.566917538642883, 1002.0 ],
					"source" : [ "obj-128", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 2 ],
					"midpoints" : [ 1041.626438736915588, 978.0, 1042.316917538642883, 978.0 ],
					"source" : [ "obj-129", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-39", 0 ],
					"midpoints" : [ 434.102734446525574, 834.0, 538.102734446525574, 834.0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 1 ],
					"midpoints" : [ 1029.721678137779236, 954.0, 1030.066917538642883, 954.0 ],
					"source" : [ "obj-130", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-126", 1 ],
					"midpoints" : [ 1017.816917538642883, 1167.0, 1046.816917538642883, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-131", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-126", 0 ],
					"midpoints" : [ 1017.816917538642883, 1116.0, 1017.816917538642883, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-131", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-133", 0 ],
					"midpoints" : [ 812.316911935806274, 2133.0, 810.908461213111877, 2133.0 ],
					"source" : [ "obj-132", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-135", 0 ],
					"midpoints" : [ 810.908461213111877, 2217.0, 810.908461213111877, 2217.0 ],
					"source" : [ "obj-133", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 0 ],
					"midpoints" : [ 926.150260925292969, 1077.0, 1017.816917538642883, 1077.0 ],
					"source" : [ "obj-134", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-140", 0 ],
					"midpoints" : [ 810.908461213111877, 2262.0, 810.908461213111877, 2262.0 ],
					"source" : [ "obj-135", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"midpoints" : [ 1240.75, 2391.0, 1040.692574501037598, 2391.0 ],
					"source" : [ "obj-136", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-133", 1 ],
					"midpoints" : [ 839.077475666999817, 2181.0, 838.908461213111877, 2181.0 ],
					"source" : [ "obj-137", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-137", 0 ],
					"midpoints" : [ 909.500011801719666, 2142.0, 839.077475666999817, 2142.0 ],
					"source" : [ "obj-138", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-143", 0 ],
					"midpoints" : [ 1576.6875, 2202.0, 1554.0, 2202.0, 1554.0, 2085.0, 1629.0, 2085.0, 1629.0, 2064.0, 1651.6875, 2064.0 ],
					"source" : [ "obj-139", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-41", 0 ],
					"midpoints" : [ 465.102734446525574, 834.0, 590.102734446525574, 834.0 ],
					"source" : [ "obj-14", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-142", 0 ],
					"midpoints" : [ 810.908461213111877, 2313.0, 810.908461213111877, 2313.0 ],
					"source" : [ "obj-140", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-139", 0 ],
					"midpoints" : [ 1651.6875, 2160.0, 1576.6875, 2160.0 ],
					"order" : 1,
					"source" : [ "obj-141", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-145", 0 ],
					"midpoints" : [ 1651.6875, 2160.0, 1651.6875, 2160.0 ],
					"order" : 0,
					"source" : [ "obj-141", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-124", 0 ],
					"midpoints" : [ 810.908461213111877, 2391.0, 637.66902232170105, 2391.0 ],
					"source" : [ "obj-142", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-141", 0 ],
					"midpoints" : [ 1651.6875, 2121.0, 1651.6875, 2121.0 ],
					"order" : 0,
					"source" : [ "obj-143", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-190", 0 ],
					"midpoints" : [ 1651.6875, 2121.0, 1554.0, 2121.0, 1554.0, 2214.0, 1635.0, 2214.0, 1635.0, 2274.0, 1615.75, 2274.0 ],
					"order" : 1,
					"source" : [ "obj-143", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-148", 0 ],
					"midpoints" : [ 812.316911935806274, 2004.0, 812.316911935806274, 2004.0 ],
					"source" : [ "obj-144", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"midpoints" : [ 1651.6875, 2325.0, 1463.273468792438507, 2325.0 ],
					"source" : [ "obj-145", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"midpoints" : [ 1325.125, 2172.0, 1356.0, 2172.0, 1356.0, 2220.0, 1240.75, 2220.0 ],
					"order" : 0,
					"source" : [ "obj-147", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-189", 0 ],
					"midpoints" : [ 1325.125, 2172.0, 1191.0, 2172.0, 1191.0, 2304.0, 1175.125, 2304.0 ],
					"order" : 1,
					"source" : [ "obj-147", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-132", 0 ],
					"midpoints" : [ 812.316911935806274, 2055.0, 812.316911935806274, 2055.0 ],
					"source" : [ "obj-148", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-153", 0 ],
					"midpoints" : [ 1422.0, 2241.0, 1398.0, 2241.0, 1398.0, 2112.0, 1495.4375, 2112.0 ],
					"source" : [ "obj-149", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 0 ],
					"midpoints" : [ 528.102734446525574, 834.0, 694.102734446525574, 834.0 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-124", 0 ],
					"midpoints" : [ 651.75352954864502, 2391.0, 637.66902232170105, 2391.0 ],
					"source" : [ "obj-150", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-149", 0 ],
					"midpoints" : [ 1495.4375, 2202.0, 1422.0, 2202.0 ],
					"order" : 1,
					"source" : [ "obj-151", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-154", 0 ],
					"midpoints" : [ 1495.4375, 2202.0, 1495.4375, 2202.0 ],
					"order" : 0,
					"source" : [ "obj-151", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-151", 0 ],
					"midpoints" : [ 1495.4375, 2172.0, 1495.4375, 2172.0 ],
					"order" : 2,
					"source" : [ "obj-153", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-190", 0 ],
					"midpoints" : [ 1495.4375, 2172.0, 1398.0, 2172.0, 1398.0, 2274.0, 1615.75, 2274.0 ],
					"order" : 1,
					"source" : [ "obj-153", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-48", 1 ],
					"midpoints" : [ 1495.4375, 2172.0, 1554.0, 2172.0, 1554.0, 2085.0, 1629.0, 2085.0, 1629.0, 1815.0, 2544.0, 1815.0, 2544.0, 1767.0, 2578.333308935165405, 1767.0 ],
					"order" : 0,
					"source" : [ "obj-153", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"midpoints" : [ 1495.4375, 2379.0, 1463.273468792438507, 2379.0 ],
					"source" : [ "obj-154", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-279", 5 ],
					"midpoints" : [ 1463.273468792438507, 2631.0, 1485.4375, 2631.0 ],
					"source" : [ "obj-155", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-48", 0 ],
					"midpoints" : [ 2590.452356338500977, 1767.0, 2567.833308935165405, 1767.0 ],
					"source" : [ "obj-156", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-160", 0 ],
					"midpoints" : [ 2051.6875, 2208.0, 2028.0, 2208.0, 2028.0, 2070.0, 2128.25, 2070.0 ],
					"source" : [ "obj-158", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-158", 0 ],
					"midpoints" : [ 2128.25, 2166.0, 2051.6875, 2166.0 ],
					"order" : 1,
					"source" : [ "obj-159", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-161", 0 ],
					"midpoints" : [ 2128.25, 2166.0, 2128.25, 2166.0 ],
					"order" : 0,
					"source" : [ "obj-159", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-43", 0 ],
					"midpoints" : [ 497.102734446525574, 834.0, 642.102734446525574, 834.0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-159", 0 ],
					"midpoints" : [ 2128.25, 2130.0, 2128.25, 2130.0 ],
					"order" : 0,
					"source" : [ "obj-160", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-278", 0 ],
					"midpoints" : [ 2128.25, 2130.0, 2115.0, 2130.0, 2115.0, 2286.0, 2098.5625, 2286.0 ],
					"order" : 1,
					"source" : [ "obj-160", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"midpoints" : [ 2128.25, 2385.0, 1973.5625, 2385.0 ],
					"source" : [ "obj-161", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-164", 0 ],
					"midpoints" : [ 1898.5625, 2244.0, 1875.0, 2244.0, 1875.0, 2118.0, 1973.5625, 2118.0 ],
					"source" : [ "obj-162", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-162", 0 ],
					"midpoints" : [ 1973.5625, 2208.0, 1898.5625, 2208.0 ],
					"order" : 1,
					"source" : [ "obj-163", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-165", 0 ],
					"midpoints" : [ 1973.5625, 2208.0, 1973.5625, 2208.0 ],
					"order" : 0,
					"source" : [ "obj-163", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-163", 0 ],
					"midpoints" : [ 1973.5625, 2175.0, 1973.5625, 2175.0 ],
					"order" : 2,
					"source" : [ "obj-164", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-232", 1 ],
					"midpoints" : [ 1973.5625, 2175.0, 2028.0, 2175.0, 2028.0, 2004.0, 3111.0, 2004.0, 3111.0, 1767.0, 3146.190446376800537, 1767.0 ],
					"order" : 0,
					"source" : [ "obj-164", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-278", 0 ],
					"midpoints" : [ 1973.5625, 2175.0, 1875.0, 2175.0, 1875.0, 2286.0, 2098.5625, 2286.0 ],
					"order" : 1,
					"source" : [ "obj-164", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"midpoints" : [ 1973.5625, 2301.0, 1980.0, 2301.0, 1980.0, 2385.0, 1973.5625, 2385.0 ],
					"source" : [ "obj-165", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-279", 10 ],
					"midpoints" : [ 1973.5625, 2631.0, 1537.9375, 2631.0 ],
					"source" : [ "obj-166", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-172", 0 ],
					"midpoints" : [ 2490.452357292175293, 1527.0, 2552.357118606567383, 1527.0 ],
					"order" : 0,
					"source" : [ "obj-167", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-370", 0 ],
					"midpoints" : [ 2490.452357292175293, 1629.0, 2214.0, 1629.0, 2214.0, 1830.0, 1576.166651725769043, 1830.0 ],
					"order" : 1,
					"source" : [ "obj-167", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"midpoints" : [ 1581.375, 2379.0, 1463.273468792438507, 2379.0 ],
					"source" : [ "obj-168", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 3 ],
					"midpoints" : [ 392.5, 2244.0, 393.25, 2244.0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"midpoints" : [ 1829.8125, 2385.0, 1973.5625, 2385.0 ],
					"source" : [ "obj-170", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-173", 0 ],
					"midpoints" : [ 1403.25, 2010.0, 1101.0, 2010.0, 1101.0, 2037.0, 1050.125, 2037.0 ],
					"order" : 6,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-174", 0 ],
					"midpoints" : [ 1403.25, 2010.0, 1204.8125, 2010.0 ],
					"order" : 5,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-176", 0 ],
					"midpoints" : [ 1403.25, 2037.0, 1495.4375, 2037.0 ],
					"order" : 3,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-177", 0 ],
					"midpoints" : [ 1403.25, 2016.0, 1973.5625, 2016.0 ],
					"order" : 1,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-178", 0 ],
					"midpoints" : [ 1403.25, 2016.0, 1651.6875, 2016.0 ],
					"order" : 2,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-179", 0 ],
					"midpoints" : [ 1403.25, 2016.0, 2131.375, 2016.0 ],
					"order" : 0,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-419", 0 ],
					"midpoints" : [ 1403.25, 2010.0, 1325.125, 2010.0 ],
					"order" : 4,
					"source" : [ "obj-171", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-114", 0 ],
					"midpoints" : [ 2552.357118606567383, 1575.0, 2590.452356338500977, 1575.0 ],
					"source" : [ "obj-172", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-97", 0 ],
					"midpoints" : [ 1050.125, 2076.0, 1050.125, 2076.0 ],
					"source" : [ "obj-173", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-88", 0 ],
					"midpoints" : [ 1204.8125, 2049.0, 1204.8125, 2049.0 ],
					"source" : [ "obj-174", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 0 ],
					"midpoints" : [ 2283.309502124786377, 1287.0, 2542.833309173583984, 1287.0 ],
					"source" : [ "obj-175", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-153", 0 ],
					"midpoints" : [ 1495.4375, 2076.0, 1495.4375, 2076.0 ],
					"source" : [ "obj-176", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-164", 0 ],
					"midpoints" : [ 1973.5625, 2079.0, 1973.5625, 2079.0 ],
					"source" : [ "obj-177", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-143", 0 ],
					"midpoints" : [ 1651.6875, 2052.0, 1651.6875, 2052.0 ],
					"source" : [ "obj-178", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-160", 0 ],
					"midpoints" : [ 2131.375, 2070.0, 2128.25, 2070.0 ],
					"source" : [ "obj-179", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 2 ],
					"midpoints" : [ 377.5, 2235.0, 381.0, 2235.0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-182", 0 ],
					"midpoints" : [ 2542.833309173583984, 1344.0, 2644.023784399032593, 1344.0 ],
					"order" : 0,
					"source" : [ "obj-181", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-183", 0 ],
					"midpoints" : [ 2542.833309173583984, 1344.0, 2589.261880159378052, 1344.0 ],
					"order" : 1,
					"source" : [ "obj-181", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-185", 0 ],
					"midpoints" : [ 2542.833309173583984, 1323.0, 2542.833309173583984, 1323.0 ],
					"order" : 2,
					"source" : [ "obj-181", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-186", 0 ],
					"midpoints" : [ 2542.833309173583984, 1344.0, 2490.452357292175293, 1344.0 ],
					"order" : 3,
					"source" : [ "obj-181", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-187", 4 ],
					"midpoints" : [ 2644.023784399032593, 1440.0, 2601.357118606567383, 1440.0 ],
					"source" : [ "obj-182", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-187", 3 ],
					"midpoints" : [ 2589.261880159378052, 1380.0, 2589.107118606567383, 1380.0 ],
					"source" : [ "obj-183", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-282", 1 ],
					"midpoints" : [ 1432.9375, 2892.0, 1432.9375, 2892.0 ],
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-187", 2 ],
					"midpoints" : [ 2542.833309173583984, 1440.0, 2576.857118606567383, 1440.0 ],
					"source" : [ "obj-185", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-187", 1 ],
					"midpoints" : [ 2490.452357292175293, 1440.0, 2564.607118606567383, 1440.0 ],
					"source" : [ "obj-186", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-172", 0 ],
					"midpoints" : [ 2552.357118606567383, 1479.0, 2552.357118606567383, 1479.0 ],
					"order" : 1,
					"source" : [ "obj-187", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-180", 0 ],
					"midpoints" : [ 2552.357118606567383, 1497.0, 2719.023783683776855, 1497.0 ],
					"order" : 0,
					"source" : [ "obj-187", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-187", 0 ],
					"midpoints" : [ 2374.976167917251587, 1440.0, 2552.357118606567383, 1440.0 ],
					"source" : [ "obj-188", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"midpoints" : [ 1175.125, 2391.0, 1040.692574501037598, 2391.0 ],
					"source" : [ "obj-189", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-59", 0 ],
					"midpoints" : [ 748.102734446525574, 834.0, 1058.102734446525574, 834.0 ],
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"midpoints" : [ 1615.75, 2325.0, 1463.273468792438507, 2325.0 ],
					"source" : [ "obj-190", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 7 ],
					"midpoints" : [ 2694.023783922195435, 1287.0, 2616.333309173583984, 1287.0 ],
					"source" : [ "obj-191", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-175", 0 ],
					"midpoints" : [ 2283.309502124786377, 1215.0, 2283.309502124786377, 1215.0 ],
					"order" : 1,
					"source" : [ "obj-192", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 0 ],
					"midpoints" : [ 2283.309502124786377, 1230.0, 2542.833309173583984, 1230.0 ],
					"order" : 0,
					"source" : [ "obj-192", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-194", 0 ],
					"midpoints" : [ 2283.309502124786377, 1128.0, 2283.309502124786377, 1128.0 ],
					"source" : [ "obj-193", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-192", 0 ],
					"midpoints" : [ 2283.309502124786377, 1170.0, 2283.309502124786377, 1170.0 ],
					"source" : [ "obj-194", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 6 ],
					"midpoints" : [ 2644.023784399032593, 1287.0, 2605.833309173583984, 1287.0 ],
					"source" : [ "obj-195", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 5 ],
					"midpoints" : [ 2599.976165771484375, 1296.0, 2595.333309173583984, 1296.0 ],
					"source" : [ "obj-196", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 4 ],
					"midpoints" : [ 2565.452356576919556, 1287.0, 2584.833309173583984, 1287.0 ],
					"source" : [ "obj-197", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 3 ],
					"midpoints" : [ 2530.928547382354736, 1287.0, 2574.333309173583984, 1287.0 ],
					"source" : [ "obj-198", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1475.654003500938416, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-199", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1468.404003500938416, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-199", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 0 ],
					"midpoints" : [ 717.102734446525574, 834.0, 1006.102734446525574, 834.0 ],
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 4 ],
					"midpoints" : [ 1517.71906840801239, 1488.0, 1517.404003500938416, 1488.0 ],
					"source" : [ "obj-200", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 3 ],
					"midpoints" : [ 1506.760165095329285, 1467.0, 1505.154003500938416, 1467.0 ],
					"source" : [ "obj-201", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 2 ],
					"midpoints" : [ 1493.061535954475403, 1443.0, 1492.904003500938416, 1443.0 ],
					"source" : [ "obj-202", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 1 ],
					"midpoints" : [ 1482.102632641792297, 1416.0, 1480.654003500938416, 1416.0 ],
					"source" : [ "obj-203", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-199", 1 ],
					"midpoints" : [ 1468.404003500938416, 1632.0, 1497.404003500938416, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-204", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-199", 0 ],
					"midpoints" : [ 1468.404003500938416, 1581.0, 1468.404003500938416, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-204", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 2 ],
					"midpoints" : [ 2496.404738187789917, 1287.0, 2563.833309173583984, 1287.0 ],
					"source" : [ "obj-205", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 1 ],
					"midpoints" : [ 2464.261881351470947, 1287.0, 2553.333309173583984, 1287.0 ],
					"source" : [ "obj-206", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 0 ],
					"midpoints" : [ 1379.362914085388184, 1545.0, 1468.404003500938416, 1545.0 ],
					"source" : [ "obj-207", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1289.352647185325623, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-208", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1282.102647185325623, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-208", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 4 ],
					"midpoints" : [ 1328.677986264228821, 1554.0, 1331.102647185325623, 1554.0 ],
					"source" : [ "obj-209", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-55", 0 ],
					"midpoints" : [ 685.102734446525574, 834.0, 954.102734446525574, 834.0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 3 ],
					"midpoints" : [ 1317.719082951545715, 1467.0, 1314.0, 1467.0, 1314.0, 1554.0, 1318.852647185325623, 1554.0 ],
					"source" : [ "obj-210", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 2 ],
					"midpoints" : [ 1304.020453810691833, 1554.0, 1306.602647185325623, 1554.0 ],
					"source" : [ "obj-211", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 1 ],
					"midpoints" : [ 1293.061550498008728, 1416.0, 1290.0, 1416.0, 1290.0, 1554.0, 1294.352647185325623, 1554.0 ],
					"source" : [ "obj-212", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-208", 1 ],
					"midpoints" : [ 1282.102647185325623, 1629.0, 1311.102647185325623, 1629.0 ],
					"order" : 0,
					"source" : [ "obj-213", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-208", 0 ],
					"midpoints" : [ 1282.102647185325623, 1581.0, 1282.102647185325623, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-213", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-191", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2694.023783922195435, 1179.0 ],
					"order" : 0,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-195", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2644.023784399032593, 1179.0 ],
					"order" : 1,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-196", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2599.976165771484375, 1179.0 ],
					"order" : 2,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-197", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2565.452356576919556, 1179.0 ],
					"order" : 3,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-198", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2530.928547382354736, 1179.0 ],
					"order" : 4,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-205", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2496.404738187789917, 1179.0 ],
					"order" : 5,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-206", 0 ],
					"midpoints" : [ 2578.547594547271729, 1179.0, 2464.261881351470947, 1179.0 ],
					"order" : 6,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-214", 0 ],
					"midpoints" : [ 2578.547594547271729, 1080.0, 2578.547594547271729, 1080.0 ],
					"source" : [ "obj-215", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 0 ],
					"midpoints" : [ 1188.951969027519226, 1524.0, 1284.0, 1524.0, 1284.0, 1554.0, 1282.102647185325623, 1554.0 ],
					"source" : [ "obj-216", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1107.160879611968994, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-217", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1099.910879611968994, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-217", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 4 ],
					"midpoints" : [ 1146.486218690872192, 1488.0, 1148.910879611968994, 1488.0 ],
					"source" : [ "obj-218", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 3 ],
					"midpoints" : [ 1135.527315378189087, 1467.0, 1110.0, 1467.0, 1110.0, 1554.0, 1136.660879611968994, 1554.0 ],
					"source" : [ "obj-219", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"midpoints" : [ 654.102734446525574, 834.0, 902.102734446525574, 834.0 ],
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 2 ],
					"midpoints" : [ 1121.828686237335205, 1554.0, 1124.410879611968994, 1554.0 ],
					"source" : [ "obj-220", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 1 ],
					"midpoints" : [ 1110.8697829246521, 1416.0, 1107.0, 1416.0, 1107.0, 1554.0, 1112.160879611968994, 1554.0 ],
					"source" : [ "obj-221", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-217", 1 ],
					"midpoints" : [ 1099.910879611968994, 1632.0, 1128.910879611968994, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-222", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-217", 0 ],
					"midpoints" : [ 1099.910879611968994, 1581.0, 1099.910879611968994, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-222", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 0 ],
					"midpoints" : [ 1006.760201454162598, 1545.0, 1099.910879611968994, 1545.0 ],
					"source" : [ "obj-225", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 918.119797468185425, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-226", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 910.869797468185425, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-226", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 4 ],
					"midpoints" : [ 957.445136547088623, 1488.0, 959.869797468185425, 1488.0 ],
					"source" : [ "obj-227", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 3 ],
					"midpoints" : [ 946.486233234405518, 1467.0, 942.0, 1467.0, 942.0, 1554.0, 947.619797468185425, 1554.0 ],
					"source" : [ "obj-228", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 2 ],
					"midpoints" : [ 932.787604093551636, 1554.0, 935.369797468185425, 1554.0 ],
					"source" : [ "obj-229", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-51", 0 ],
					"midpoints" : [ 622.102734446525574, 834.0, 850.102734446525574, 834.0 ],
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 1 ],
					"midpoints" : [ 921.82870078086853, 1416.0, 918.0, 1416.0, 918.0, 1554.0, 923.119797468185425, 1554.0 ],
					"source" : [ "obj-230", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-226", 1 ],
					"midpoints" : [ 910.869797468185425, 1632.0, 939.869797468185425, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-231", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-226", 0 ],
					"midpoints" : [ 910.869797468185425, 1581.0, 910.869797468185425, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-231", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-368", 0 ],
					"midpoints" : [ 3135.690446376800537, 1857.0, 2190.452360153198242, 1857.0 ],
					"source" : [ "obj-232", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-250", 0 ],
					"midpoints" : [ 3158.309493780136108, 1602.0, 3158.309493780136108, 1602.0 ],
					"order" : 0,
					"source" : [ "obj-233", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-260", 1 ],
					"midpoints" : [ 3158.309493780136108, 1617.0, 3119.91625452041626, 1617.0 ],
					"order" : 1,
					"source" : [ "obj-233", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 0 ],
					"midpoints" : [ 817.719119310379028, 1545.0, 910.869797468185425, 1545.0 ],
					"source" : [ "obj-234", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 724.969126582145691, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-235", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 717.719126582145691, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-235", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 4 ],
					"midpoints" : [ 768.404054403305054, 1554.0, 766.719126582145691, 1554.0 ],
					"source" : [ "obj-236", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 3 ],
					"midpoints" : [ 757.445151090621948, 1467.0, 754.469126582145691, 1467.0 ],
					"source" : [ "obj-237", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 2 ],
					"midpoints" : [ 743.746521949768066, 1443.0, 742.219126582145691, 1443.0 ],
					"source" : [ "obj-238", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 1 ],
					"midpoints" : [ 732.787618637084961, 1416.0, 729.969126582145691, 1416.0 ],
					"source" : [ "obj-239", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 0 ],
					"midpoints" : [ 591.102734446525574, 834.0, 798.102734446525574, 834.0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-235", 1 ],
					"midpoints" : [ 717.719126582145691, 1632.0, 746.719126582145691, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-240", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-235", 0 ],
					"midpoints" : [ 717.719126582145691, 1581.0, 717.719126582145691, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-240", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-243", 0 ],
					"midpoints" : [ 697.171182870864868, 1470.0, 628.678037166595459, 1470.0 ],
					"source" : [ "obj-241", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-224", 0 ],
					"midpoints" : [ 3264.261873722076416, 1689.0, 3264.261873722076416, 1689.0 ],
					"order" : 0,
					"source" : [ "obj-242", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-250", 1 ],
					"midpoints" : [ 3264.261873722076416, 1698.0, 3177.0, 1698.0, 3177.0, 1695.0, 3168.809493780136108, 1695.0 ],
					"order" : 1,
					"source" : [ "obj-242", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 0 ],
					"midpoints" : [ 628.678037166595459, 1545.0, 717.719126582145691, 1545.0 ],
					"source" : [ "obj-243", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 540.037633180618286, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-244", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 532.787633180618286, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-244", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 4 ],
					"midpoints" : [ 580.732835173606873, 1488.0, 581.787633180618286, 1488.0 ],
					"source" : [ "obj-245", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 3 ],
					"midpoints" : [ 568.404068946838379, 1467.0, 569.537633180618286, 1467.0 ],
					"source" : [ "obj-246", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 2 ],
					"midpoints" : [ 557.445165634155273, 1443.0, 557.287633180618286, 1443.0 ],
					"source" : [ "obj-247", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 1 ],
					"midpoints" : [ 543.746536493301392, 1416.0, 545.037633180618286, 1416.0 ],
					"source" : [ "obj-248", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-244", 1 ],
					"midpoints" : [ 532.787633180618286, 1629.0, 561.787633180618286, 1629.0 ],
					"order" : 0,
					"source" : [ "obj-249", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-244", 0 ],
					"midpoints" : [ 532.787633180618286, 1581.0, 532.787633180618286, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-249", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-47", 0 ],
					"midpoints" : [ 559.102734446525574, 834.0, 746.102734446525574, 834.0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-232", 0 ],
					"midpoints" : [ 3158.309493780136108, 1755.0, 3135.690446376800537, 1755.0 ],
					"source" : [ "obj-250", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 0 ],
					"midpoints" : [ 439.63695502281189, 1545.0, 532.787633180618286, 1545.0 ],
					"source" : [ "obj-252", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 357.845865607261658, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-253", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 350.595865607261658, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-253", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 4 ],
					"midpoints" : [ 398.541067600250244, 1554.0, 399.595865607261658, 1554.0 ],
					"source" : [ "obj-254", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 3 ],
					"midpoints" : [ 386.21230137348175, 1554.0, 387.345865607261658, 1554.0 ],
					"source" : [ "obj-255", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 2 ],
					"midpoints" : [ 371.14380931854248, 1545.0, 375.095865607261658, 1545.0 ],
					"source" : [ "obj-256", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 1 ],
					"midpoints" : [ 361.554768919944763, 1416.0, 357.0, 1416.0, 357.0, 1554.0, 362.845865607261658, 1554.0 ],
					"source" : [ "obj-257", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-253", 1 ],
					"midpoints" : [ 350.595865607261658, 1632.0, 379.595865607261658, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-258", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-253", 0 ],
					"midpoints" : [ 350.595865607261658, 1581.0, 350.595865607261658, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-258", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-268", 0 ],
					"midpoints" : [ 3058.309494733810425, 1518.0, 3120.214256048202515, 1518.0 ],
					"order" : 0,
					"source" : [ "obj-259", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-375", 0 ],
					"midpoints" : [ 3058.309494733810425, 1617.0, 2769.0, 1617.0, 2769.0, 1857.0, 2064.0, 1857.0, 2064.0, 1908.0, 2060.690456628799438, 1908.0 ],
					"order" : 1,
					"source" : [ "obj-259", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 1 ],
					"midpoints" : [ 366.5, 2109.0, 363.0, 2109.0, 363.0, 2244.0, 368.75, 2244.0 ],
					"source" : [ "obj-26", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 0 ],
					"midpoints" : [ 257.445187449455261, 1545.0, 350.595865607261658, 1545.0 ],
					"source" : [ "obj-261", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 168.804783463478088, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-262", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 161.554783463478088, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-262", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 4 ],
					"midpoints" : [ 209.499985456466675, 1554.0, 210.554783463478088, 1554.0 ],
					"source" : [ "obj-263", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 3 ],
					"midpoints" : [ 197.171219229698181, 1554.0, 198.304783463478088, 1554.0 ],
					"source" : [ "obj-264", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 2 ],
					"midpoints" : [ 182.102727174758911, 1545.0, 186.054783463478088, 1545.0 ],
					"source" : [ "obj-265", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 1 ],
					"midpoints" : [ 171.143823862075806, 1416.0, 168.0, 1416.0, 168.0, 1554.0, 173.804783463478088, 1554.0 ],
					"source" : [ "obj-266", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-262", 1 ],
					"midpoints" : [ 161.554783463478088, 1632.0, 190.554783463478088, 1632.0 ],
					"order" : 0,
					"source" : [ "obj-267", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-262", 0 ],
					"midpoints" : [ 161.554783463478088, 1581.0, 161.554783463478088, 1581.0 ],
					"order" : 1,
					"source" : [ "obj-267", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-233", 0 ],
					"midpoints" : [ 3120.214256048202515, 1563.0, 3158.309493780136108, 1563.0 ],
					"source" : [ "obj-268", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 0 ],
					"midpoints" : [ 2851.166639566421509, 1275.0, 3110.690446615219116, 1275.0 ],
					"source" : [ "obj-269", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-54", 1 ],
					"midpoints" : [ 356.5, 2280.0, 615.0, 2280.0, 615.0, 2196.0, 648.16902232170105, 2196.0 ],
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 0 ],
					"midpoints" : [ 68.404105305671692, 1545.0, 161.554783463478088, 1545.0 ],
					"source" : [ "obj-270", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 1577.340665698051453, 1077.0 ],
					"order" : 0,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-107", 0 ],
					"midpoints" : [ 89.189348995685577, 1059.0, 1461.0, 1059.0, 1461.0, 1023.0, 1485.674009084701538, 1023.0 ],
					"order" : 1,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 1389.245448231697083, 1077.0 ],
					"order" : 3,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-116", 0 ],
					"midpoints" : [ 89.189348995685577, 963.0, 255.0, 963.0, 255.0, 915.0, 1308.0, 915.0, 1308.0, 1002.0, 1296.388315558433533, 1002.0 ],
					"order" : 5,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-122", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 1207.102611064910889, 1077.0 ],
					"order" : 7,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-125", 0 ],
					"midpoints" : [ 89.189348995685577, 1059.0, 1092.0, 1059.0, 1092.0, 1023.0, 1115.435954451560974, 1023.0 ],
					"order" : 9,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-131", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 1017.816917538642883, 1077.0 ],
					"order" : 11,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-134", 0 ],
					"midpoints" : [ 89.189348995685577, 1059.0, 903.0, 1059.0, 903.0, 1023.0, 926.150260925292969, 1023.0 ],
					"order" : 13,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-204", 0 ],
					"midpoints" : [ 89.189348995685577, 1254.801411867141724, 1468.404003500938416, 1254.801411867141724 ],
					"order" : 2,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-207", 0 ],
					"midpoints" : [ 89.189348995685577, 1220.554839015007019, 1379.362914085388184, 1220.554839015007019 ],
					"order" : 4,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-213", 0 ],
					"midpoints" : [ 89.189348995685577, 1254.801411867141724, 1282.102647185325623, 1254.801411867141724 ],
					"order" : 6,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-216", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 1188.951969027519226, 1380.0 ],
					"order" : 8,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 1099.910879611968994, 1545.0 ],
					"order" : 10,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-225", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 1006.760201454162598, 1380.0 ],
					"order" : 12,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-231", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 910.869797468185425, 1545.0 ],
					"order" : 14,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-234", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 817.719119310379028, 1380.0 ],
					"order" : 16,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 717.719126582145691, 1545.0 ],
					"order" : 18,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-243", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 628.678037166595459, 1380.0 ],
					"order" : 20,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 532.787633180618286, 1545.0 ],
					"order" : 22,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-252", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 441.0, 1380.0, 441.0, 1485.0, 439.63695502281189, 1485.0 ],
					"order" : 24,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-258", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 350.595865607261658, 1545.0 ],
					"order" : 26,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-261", 0 ],
					"midpoints" : [ 89.189348995685577, 1380.0, 257.445187449455261, 1380.0 ],
					"order" : 28,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-267", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 168.0, 1476.0, 168.0, 1545.0, 161.554783463478088, 1545.0 ],
					"order" : 30,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-270", 0 ],
					"midpoints" : [ 89.189348995685577, 1476.0, 68.404105305671692, 1476.0 ],
					"order" : 31,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-60", 0 ],
					"midpoints" : [ 89.189348995685577, 1011.0, 176.150343179702759, 1011.0 ],
					"order" : 29,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 268.102734446525574, 1077.0 ],
					"order" : 27,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 457.102693319320679, 1077.0 ],
					"order" : 23,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-80", 0 ],
					"midpoints" : [ 89.189348995685577, 1011.0, 294.0, 1011.0, 294.0, 1035.0, 351.0, 1035.0, 351.0, 1023.0, 365.436036705970764, 1023.0 ],
					"order" : 25,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 828.197946429252625, 1077.0 ],
					"order" : 15,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-89", 0 ],
					"midpoints" : [ 89.189348995685577, 1059.0, 714.0, 1059.0, 714.0, 1023.0, 736.53128981590271, 1023.0 ],
					"order" : 17,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 0 ],
					"midpoints" : [ 89.189348995685577, 1077.0, 640.102728962898254, 1077.0 ],
					"order" : 19,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-98", 0 ],
					"midpoints" : [ 89.189348995685577, 963.0, 255.0, 963.0, 255.0, 915.0, 547.245596289634705, 915.0 ],
					"order" : 21,
					"source" : [ "obj-271", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-276", 0 ],
					"midpoints" : [ 116.354702115058899, 840.0, 107.102735638618469, 840.0 ],
					"source" : [ "obj-274", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-283", 0 ],
					"midpoints" : [ 3110.690446615219116, 1332.0, 3211.880921840667725, 1332.0 ],
					"order" : 0,
					"source" : [ "obj-275", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-285", 0 ],
					"midpoints" : [ 3110.690446615219116, 1332.0, 3157.119017601013184, 1332.0 ],
					"order" : 1,
					"source" : [ "obj-275", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-286", 0 ],
					"midpoints" : [ 3110.690446615219116, 1314.0, 3110.690446615219116, 1314.0 ],
					"order" : 2,
					"source" : [ "obj-275", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-290", 0 ],
					"midpoints" : [ 3110.690446615219116, 1332.0, 3058.309494733810425, 1332.0 ],
					"order" : 3,
					"source" : [ "obj-275", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-271", 0 ],
					"midpoints" : [ 107.102735638618469, 915.0, 89.189348995685577, 915.0 ],
					"source" : [ "obj-276", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-281", 0 ],
					"midpoints" : [ 209.499985456466675, 1950.0, 209.499985456466675, 1950.0 ],
					"source" : [ "obj-277", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"midpoints" : [ 2098.5625, 2385.0, 1973.5625, 2385.0 ],
					"source" : [ "obj-278", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-280", 0 ],
					"midpoints" : [ 1432.9375, 2670.0, 1432.9375, 2670.0 ],
					"source" : [ "obj-279", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 0 ],
					"midpoints" : [ 444.5, 2235.0, 356.5, 2235.0 ],
					"source" : [ "obj-28", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-184", 0 ],
					"midpoints" : [ 1432.9375, 2721.0, 1432.9375, 2721.0 ],
					"source" : [ "obj-280", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-56", 1 ],
					"midpoints" : [ 209.499985456466675, 2217.0, 228.656633496284485, 2217.0 ],
					"source" : [ "obj-281", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"midpoints" : [ 1391.9375, 3051.0, 1333.353100538253784, 3051.0 ],
					"source" : [ "obj-282", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-292", 4 ],
					"midpoints" : [ 3211.880921840667725, 1431.0, 3169.214256048202515, 1431.0 ],
					"source" : [ "obj-283", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-292", 3 ],
					"midpoints" : [ 3157.119017601013184, 1371.0, 3156.964256048202515, 1371.0 ],
					"source" : [ "obj-285", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-292", 2 ],
					"midpoints" : [ 3110.690446615219116, 1431.0, 3144.714256048202515, 1431.0 ],
					"source" : [ "obj-286", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-291", 0 ],
					"midpoints" : [ 163.531307816505432, 1227.0, 163.531307816505432, 1227.0 ],
					"source" : [ "obj-287", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-66", 0 ],
					"midpoints" : [ 277.102734446525574, 924.0, 280.352734446525574, 924.0 ],
					"order" : 3,
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-67", 0 ],
					"midpoints" : [ 277.102734446525574, 915.0, 267.0, 915.0, 267.0, 951.0, 292.602734446525574, 951.0 ],
					"order" : 2,
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-68", 0 ],
					"midpoints" : [ 277.102734446525574, 915.0, 255.0, 915.0, 255.0, 975.0, 304.852734446525574, 975.0 ],
					"order" : 1,
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-69", 0 ],
					"midpoints" : [ 277.102734446525574, 915.0, 255.0, 915.0, 255.0, 1002.0, 317.102734446525574, 1002.0 ],
					"order" : 0,
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-292", 1 ],
					"midpoints" : [ 3058.309494733810425, 1431.0, 3132.464256048202515, 1431.0 ],
					"source" : [ "obj-290", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-108", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 1389.245448231697083, 1167.0 ],
					"order" : 2,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-117", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 1207.102611064910889, 1167.0 ],
					"order" : 4,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-126", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 1017.816917538642883, 1167.0 ],
					"order" : 6,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-199", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 1269.0, 1380.0, 1269.0, 1476.0, 1305.0, 1476.0, 1305.0, 1545.0, 1443.0, 1545.0, 1443.0, 1632.0, 1468.404003500938416, 1632.0 ],
					"order" : 1,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-208", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 897.0, 1380.0, 897.0, 1476.0, 933.0, 1476.0, 933.0, 1545.0, 1077.0, 1545.0, 1077.0, 1629.0, 1282.102647185325623, 1629.0 ],
					"order" : 3,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-217", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 897.0, 1380.0, 897.0, 1476.0, 933.0, 1476.0, 933.0, 1545.0, 1077.0, 1545.0, 1077.0, 1632.0, 1099.910879611968994, 1632.0 ],
					"order" : 5,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-226", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 519.0, 1380.0, 519.0, 1476.0, 558.0, 1476.0, 558.0, 1545.0, 888.0, 1545.0, 888.0, 1632.0, 910.869797468185425, 1632.0 ],
					"order" : 7,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-235", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 519.0, 1380.0, 519.0, 1476.0, 558.0, 1476.0, 558.0, 1545.0, 693.0, 1545.0, 693.0, 1632.0, 717.719126582145691, 1632.0 ],
					"order" : 9,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-244", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 339.0, 1380.0, 339.0, 1476.0, 375.0, 1476.0, 375.0, 1545.0, 510.0, 1545.0, 510.0, 1629.0, 532.787633180618286, 1629.0 ],
					"order" : 11,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-253", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 147.0, 1380.0, 147.0, 1476.0, 186.0, 1476.0, 186.0, 1545.0, 327.0, 1545.0, 327.0, 1632.0, 350.595865607261658, 1632.0 ],
					"order" : 13,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-262", 0 ],
					"midpoints" : [ 163.531307816505432, 1380.0, 147.0, 1380.0, 147.0, 1476.0, 168.0, 1476.0, 168.0, 1545.0, 138.0, 1545.0, 138.0, 1632.0, 161.554783463478088, 1632.0 ],
					"order" : 14,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 457.102693319320679, 1167.0 ],
					"order" : 12,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 828.197946429252625, 1167.0 ],
					"order" : 8,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-90", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 640.102728962898254, 1167.0 ],
					"order" : 10,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-99", 0 ],
					"midpoints" : [ 163.531307816505432, 1269.0, 246.0, 1269.0, 246.0, 1167.0, 1577.340665698051453, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-291", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-268", 0 ],
					"midpoints" : [ 3120.214256048202515, 1467.0, 3120.214256048202515, 1467.0 ],
					"order" : 1,
					"source" : [ "obj-292", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-486", 0 ],
					"midpoints" : [ 3120.214256048202515, 1479.0, 3247.543416500091553, 1479.0 ],
					"order" : 0,
					"source" : [ "obj-292", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-292", 0 ],
					"midpoints" : [ 2942.833305358886719, 1431.0, 3120.214256048202515, 1431.0 ],
					"source" : [ "obj-293", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-215", 0 ],
					"order" : 1,
					"source" : [ "obj-294", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-299", 0 ],
					"midpoints" : [ 2024.016143441200256, 1026.0, 2024.016143441200256, 1026.0 ],
					"order" : 2,
					"source" : [ "obj-294", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-363", 0 ],
					"order" : 0,
					"source" : [ "obj-294", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 7 ],
					"midpoints" : [ 3261.880921363830566, 1275.0, 3184.190446615219116, 1275.0 ],
					"source" : [ "obj-296", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-294", 0 ],
					"midpoints" : [ 2123.209692537784576, 990.0, 2024.016143441200256, 990.0 ],
					"source" : [ "obj-297", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-297", 0 ],
					"midpoints" : [ 2123.209692537784576, 933.0, 2123.209692537784576, 933.0 ],
					"source" : [ "obj-298", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-302", 0 ],
					"midpoints" : [ 2024.016143441200256, 1080.0, 2024.016143441200256, 1080.0 ],
					"source" : [ "obj-299", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-269", 0 ],
					"midpoints" : [ 2851.166639566421509, 1206.0, 2851.166639566421509, 1206.0 ],
					"order" : 1,
					"source" : [ "obj-300", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 0 ],
					"midpoints" : [ 2851.166639566421509, 1221.0, 3110.690446615219116, 1221.0 ],
					"order" : 0,
					"source" : [ "obj-300", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-317", 0 ],
					"midpoints" : [ 2851.166639566421509, 1119.0, 2851.166639566421509, 1119.0 ],
					"source" : [ "obj-301", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-303", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 1908.693561971187592, 1179.0 ],
					"order" : 6,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-304", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 1941.758078336715698, 1179.0 ],
					"order" : 5,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-305", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 1975.629046320915222, 1179.0 ],
					"order" : 4,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-313", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 2010.306465923786163, 1179.0 ],
					"order" : 3,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-314", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 2045.322594881057739, 1179.0 ],
					"order" : 2,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-315", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 2088.532272934913635, 1179.0 ],
					"order" : 1,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-335", 0 ],
					"midpoints" : [ 2024.016143441200256, 1179.0, 2138.532273292541504, 1179.0 ],
					"order" : 0,
					"source" : [ "obj-302", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 1 ],
					"midpoints" : [ 1908.693561971187592, 1287.0, 1998.461727142333984, 1287.0 ],
					"source" : [ "obj-303", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 2 ],
					"midpoints" : [ 1941.758078336715698, 1287.0, 2008.961727142333984, 1287.0 ],
					"source" : [ "obj-304", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 3 ],
					"midpoints" : [ 1975.629046320915222, 1287.0, 2019.461727142333984, 1287.0 ],
					"source" : [ "obj-305", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-345", 0 ],
					"midpoints" : [ 350.806125044822693, 684.0, 329.852734446525574, 684.0 ],
					"source" : [ "obj-306", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-347", 0 ],
					"midpoints" : [ 413.517990946769714, 684.0, 434.937482714653015, 684.0 ],
					"source" : [ "obj-307", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-346", 0 ],
					"midpoints" : [ 382.162057995796204, 651.0, 381.547650933265686, 651.0 ],
					"source" : [ "obj-308", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-348", 0 ],
					"midpoints" : [ 538.094265103340149, 672.0, 643.412063956260681, 672.0 ],
					"source" : [ "obj-309", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-91", 0 ],
					"midpoints" : [ 381.102734446525574, 915.0, 627.0, 915.0, 627.0, 1002.0, 684.0, 1002.0, 684.0, 996.0, 688.9122474193573, 996.0 ],
					"order" : 0,
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-92", 0 ],
					"midpoints" : [ 381.102734446525574, 915.0, 627.0, 915.0, 627.0, 975.0, 675.817010760307312, 975.0 ],
					"order" : 1,
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-93", 0 ],
					"midpoints" : [ 381.102734446525574, 915.0, 627.0, 915.0, 627.0, 951.0, 663.912250161170959, 951.0 ],
					"order" : 2,
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-94", 0 ],
					"midpoints" : [ 381.102734446525574, 915.0, 652.007489562034607, 915.0 ],
					"order" : 3,
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-349", 0 ],
					"midpoints" : [ 507.585789799690247, 672.0, 590.022232174873352, 672.0 ],
					"source" : [ "obj-310", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-350", 0 ],
					"midpoints" : [ 476.229856848716736, 651.0, 495.0, 651.0, 495.0, 672.0, 538.32731568813324, 672.0 ],
					"source" : [ "obj-311", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-351", 0 ],
					"midpoints" : [ 444.873923897743225, 681.0, 486.632399201393127, 681.0 ],
					"source" : [ "obj-312", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 4 ],
					"midpoints" : [ 2010.306465923786163, 1287.0, 2029.961727142333984, 1287.0 ],
					"source" : [ "obj-313", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 5 ],
					"midpoints" : [ 2045.322594881057739, 1296.0, 2040.461727142333984, 1296.0 ],
					"source" : [ "obj-314", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 6 ],
					"midpoints" : [ 2088.532272934913635, 1287.0, 2050.961727142333984, 1287.0 ],
					"source" : [ "obj-315", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-333", 0 ],
					"midpoints" : [ 1728.048399388790131, 1170.0, 1728.048399388790131, 1170.0 ],
					"source" : [ "obj-316", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-300", 0 ],
					"midpoints" : [ 2851.166639566421509, 1161.0, 2851.166639566421509, 1161.0 ],
					"source" : [ "obj-317", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 6 ],
					"midpoints" : [ 3211.880921840667725, 1275.0, 3173.690446615219116, 1275.0 ],
					"source" : [ "obj-318", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-316", 0 ],
					"midpoints" : [ 1728.048399388790131, 1128.0, 1728.048399388790131, 1128.0 ],
					"source" : [ "obj-319", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-425", 0 ],
					"midpoints" : [ 1333.353100538253784, 3210.0, 1254.065193653106689, 3210.0 ],
					"source" : [ "obj-32", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 5 ],
					"midpoints" : [ 3167.833303213119507, 1284.0, 3163.190446615219116, 1284.0 ],
					"source" : [ "obj-320", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 4 ],
					"midpoints" : [ 3133.309494018554688, 1275.0, 3152.690446615219116, 1275.0 ],
					"source" : [ "obj-321", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-353", 0 ],
					"midpoints" : [ 760.102734446525574, 672.0, 1007.818852305412292, 672.0 ],
					"source" : [ "obj-322", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-354", 0 ],
					"midpoints" : [ 728.102734446525574, 672.0, 956.12393581867218, 672.0 ],
					"source" : [ "obj-323", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-355", 0 ],
					"midpoints" : [ 696.102734446525574, 672.0, 904.429019331932068, 672.0 ],
					"source" : [ "obj-324", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-356", 0 ],
					"midpoints" : [ 665.212912201881409, 672.0, 851.886645197868347, 672.0 ],
					"source" : [ "obj-325", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-357", 0 ],
					"midpoints" : [ 633.00952160358429, 672.0, 799.344271063804626, 672.0 ],
					"source" : [ "obj-326", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-358", 0 ],
					"midpoints" : [ 601.653588652610779, 672.0, 747.649354577064514, 672.0 ],
					"source" : [ "obj-327", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-359", 0 ],
					"midpoints" : [ 569.45019805431366, 672.0, 695.106980443000793, 672.0 ],
					"source" : [ "obj-328", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 3 ],
					"midpoints" : [ 3098.785684823989868, 1275.0, 3142.190446615219116, 1275.0 ],
					"source" : [ "obj-329", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 0 ],
					"midpoints" : [ 329.102734446525574, 939.0, 444.0, 939.0, 444.0, 1002.0, 501.0, 1002.0, 501.0, 996.0, 505.912211775779724, 996.0 ],
					"order" : 0,
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-74", 0 ],
					"midpoints" : [ 329.102734446525574, 939.0, 444.0, 939.0, 444.0, 975.0, 493.852693319320679, 975.0 ],
					"order" : 1,
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 0 ],
					"midpoints" : [ 329.102734446525574, 939.0, 444.0, 939.0, 444.0, 951.0, 480.912214517593384, 951.0 ],
					"order" : 2,
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 0 ],
					"midpoints" : [ 329.102734446525574, 915.0, 469.007453918457031, 915.0 ],
					"order" : 3,
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-306", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 350.806125044822693, 615.0 ],
					"order" : 14,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-307", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 413.517990946769714, 615.0 ],
					"order" : 12,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-308", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 382.162057995796204, 615.0 ],
					"order" : 13,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-309", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 538.094265103340149, 615.0 ],
					"order" : 8,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-310", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 507.585789799690247, 615.0 ],
					"order" : 9,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-311", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 476.229856848716736, 615.0 ],
					"order" : 10,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-312", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 444.873923897743225, 615.0 ],
					"order" : 11,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-322", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 760.102734446525574, 615.0 ],
					"order" : 1,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-323", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 728.102734446525574, 615.0 ],
					"order" : 2,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-324", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 696.102734446525574, 615.0 ],
					"order" : 3,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-325", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 665.212912201881409, 615.0 ],
					"order" : 4,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-326", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 633.00952160358429, 615.0 ],
					"order" : 5,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-327", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 601.653588652610779, 615.0 ],
					"order" : 6,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-328", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 569.45019805431366, 615.0 ],
					"order" : 7,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-360", 0 ],
					"midpoints" : [ 657.101295590400696, 615.0, 788.941728711128235, 615.0 ],
					"order" : 0,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-330", 0 ],
					"midpoints" : [ 657.101295590400696, 552.0, 657.101295590400696, 552.0 ],
					"source" : [ "obj-331", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-334", 0 ],
					"midpoints" : [ 648.101295590400696, 462.0, 610.602734446525574, 462.0 ],
					"source" : [ "obj-332", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 0 ],
					"midpoints" : [ 1728.048399388790131, 1230.0, 1987.961727142333984, 1230.0 ],
					"order" : 0,
					"source" : [ "obj-333", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-390", 0 ],
					"midpoints" : [ 1728.048399388790131, 1215.0, 1728.048399388790131, 1215.0 ],
					"order" : 1,
					"source" : [ "obj-333", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-331", 0 ],
					"midpoints" : [ 610.602734446525574, 501.0, 657.101295590400696, 501.0 ],
					"source" : [ "obj-334", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 7 ],
					"midpoints" : [ 2138.532273292541504, 1287.0, 2061.461727142333984, 1287.0 ],
					"source" : [ "obj-335", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-334", 0 ],
					"midpoints" : [ 578.712915778160095, 465.0, 606.0, 465.0, 606.0, 471.0, 610.602734446525574, 471.0 ],
					"source" : [ "obj-336", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 2 ],
					"midpoints" : [ 3064.261875629425049, 1275.0, 3131.690446615219116, 1275.0 ],
					"source" : [ "obj-337", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-275", 1 ],
					"midpoints" : [ 3032.119018793106079, 1275.0, 3121.190446615219116, 1275.0 ],
					"source" : [ "obj-339", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-282", 0 ],
					"midpoints" : [ 202.271091461181641, 2949.0, 1391.9375, 2949.0 ],
					"source" : [ "obj-34", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-296", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3261.880921363830566, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-318", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3211.880921840667725, 1167.0 ],
					"order" : 1,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-320", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3167.833303213119507, 1167.0 ],
					"order" : 2,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-321", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3133.309494018554688, 1167.0 ],
					"order" : 3,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-329", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3098.785684823989868, 1167.0 ],
					"order" : 4,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-337", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3064.261875629425049, 1167.0 ],
					"order" : 5,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-339", 0 ],
					"midpoints" : [ 3146.40473198890686, 1167.0, 3032.119018793106079, 1167.0 ],
					"order" : 6,
					"source" : [ "obj-340", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 4 ],
					"midpoints" : [ 2088.532272934913635, 1440.0, 2046.266143441200256, 1440.0 ],
					"source" : [ "obj-341", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 3 ],
					"midpoints" : [ 2034.016143441200256, 1380.0, 2034.016143441200256, 1380.0 ],
					"source" : [ "obj-342", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 2 ],
					"midpoints" : [ 1987.961727142333984, 1440.0, 2021.766143441200256, 1440.0 ],
					"source" : [ "obj-343", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 1 ],
					"midpoints" : [ 1935.008078336715698, 1440.0, 2009.516143441200256, 1440.0 ],
					"source" : [ "obj-344", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 1 ],
					"midpoints" : [ 329.852734446525574, 744.0, 318.602734446525574, 744.0 ],
					"source" : [ "obj-345", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 1 ],
					"midpoints" : [ 381.547650933265686, 744.0, 350.602734446525574, 744.0 ],
					"source" : [ "obj-346", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 1 ],
					"midpoints" : [ 434.937482714653015, 744.0, 381.602734446525574, 744.0 ],
					"source" : [ "obj-347", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 1 ],
					"midpoints" : [ 643.412063956260681, 744.0, 507.602734446525574, 744.0 ],
					"source" : [ "obj-348", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 1 ],
					"midpoints" : [ 590.022232174873352, 744.0, 475.602734446525574, 744.0 ],
					"source" : [ "obj-349", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-82", 0 ],
					"midpoints" : [ 434.102734446525574, 915.0, 816.0, 915.0, 816.0, 1002.0, 873.0, 1002.0, 873.0, 996.0, 877.00746488571167, 996.0 ],
					"order" : 0,
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-83", 0 ],
					"midpoints" : [ 434.102734446525574, 915.0, 816.0, 915.0, 816.0, 975.0, 865.102704286575317, 975.0 ],
					"order" : 1,
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-84", 0 ],
					"midpoints" : [ 434.102734446525574, 915.0, 816.0, 915.0, 816.0, 951.0, 852.00746762752533, 951.0 ],
					"order" : 2,
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"midpoints" : [ 434.102734446525574, 915.0, 840.102707028388977, 915.0 ],
					"order" : 3,
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 1 ],
					"midpoints" : [ 538.32731568813324, 744.0, 444.602734446525574, 744.0 ],
					"source" : [ "obj-350", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 1 ],
					"midpoints" : [ 486.632399201393127, 744.0, 413.602734446525574, 744.0 ],
					"source" : [ "obj-351", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 1 ],
					"midpoints" : [ 1061.208684086799622, 744.0, 762.102734446525574, 744.0 ],
					"order" : 1,
					"source" : [ "obj-352", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-367", 0 ],
					"midpoints" : [ 1061.208684086799622, 744.0, 980.102734446525574, 744.0 ],
					"order" : 0,
					"source" : [ "obj-352", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 1 ],
					"midpoints" : [ 1007.818852305412292, 744.0, 731.102734446525574, 744.0 ],
					"source" : [ "obj-353", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 1 ],
					"midpoints" : [ 956.12393581867218, 744.0, 699.102734446525574, 744.0 ],
					"source" : [ "obj-354", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 1 ],
					"midpoints" : [ 904.429019331932068, 744.0, 668.102734446525574, 744.0 ],
					"source" : [ "obj-355", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 1 ],
					"midpoints" : [ 851.886645197868347, 744.0, 636.102734446525574, 744.0 ],
					"source" : [ "obj-356", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 1 ],
					"midpoints" : [ 799.344271063804626, 744.0, 604.102734446525574, 744.0 ],
					"source" : [ "obj-357", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 1 ],
					"midpoints" : [ 747.649354577064514, 744.0, 573.102734446525574, 744.0 ],
					"source" : [ "obj-358", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 1 ],
					"midpoints" : [ 695.106980443000793, 744.0, 538.602734446525574, 744.0 ],
					"source" : [ "obj-359", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-352", 0 ],
					"midpoints" : [ 788.941728711128235, 672.0, 1061.208684086799622, 672.0 ],
					"source" : [ "obj-360", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-383", 0 ],
					"midpoints" : [ 1997.266143441200256, 1497.0, 2164.338725090026855, 1497.0 ],
					"order" : 0,
					"source" : [ "obj-361", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-392", 0 ],
					"midpoints" : [ 1997.266143441200256, 1479.0, 1997.266143441200256, 1479.0 ],
					"order" : 1,
					"source" : [ "obj-361", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 0 ],
					"midpoints" : [ 1819.983883917331696, 1440.0, 1997.266143441200256, 1440.0 ],
					"source" : [ "obj-362", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-340", 0 ],
					"midpoints" : [ 3146.40473198890686, 1068.0, 3146.40473198890686, 1068.0 ],
					"source" : [ "obj-363", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-190", 0 ],
					"midpoints" : [ 1681.375, 1938.0, 1623.0, 1938.0, 1623.0, 2166.0, 1554.0, 2166.0, 1554.0, 2214.0, 1635.0, 2214.0, 1635.0, 2274.0, 1615.75, 2274.0 ],
					"order" : 1,
					"source" : [ "obj-364", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-365", 0 ],
					"midpoints" : [ 1681.375, 1899.0, 1681.375, 1899.0 ],
					"order" : 0,
					"source" : [ "obj-364", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"midpoints" : [ 1681.375, 2016.0, 1398.0, 2016.0, 1398.0, 2310.0, 1463.273468792438507, 2310.0 ],
					"source" : [ "obj-365", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"midpoints" : [ 2144.023789167404175, 2016.0, 2103.0, 2016.0, 2103.0, 2181.0, 2115.0, 2181.0, 2115.0, 2286.0, 1980.0, 2286.0, 1980.0, 2385.0, 1973.5625, 2385.0 ],
					"source" : [ "obj-366", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"midpoints" : [ 980.102734446525574, 783.0, 783.0, 783.0, 783.0, 744.0, 210.0, 744.0, 210.0, 642.0, 160.068838000297546, 642.0 ],
					"source" : [ "obj-367", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-278", 0 ],
					"midpoints" : [ 2190.452360153198242, 1938.0, 2109.0, 1938.0, 2109.0, 2016.0, 2103.0, 2016.0, 2103.0, 2181.0, 2115.0, 2181.0, 2115.0, 2286.0, 2098.5625, 2286.0 ],
					"order" : 1,
					"source" : [ "obj-368", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-366", 0 ],
					"midpoints" : [ 2190.452360153198242, 1938.0, 2144.023789167404175, 1938.0 ],
					"order" : 0,
					"source" : [ "obj-368", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-127", 0 ],
					"midpoints" : [ 486.102734446525574, 936.090426981449127, 1066.626435995101929, 936.090426981449127 ],
					"order" : 0,
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-128", 0 ],
					"midpoints" : [ 486.102734446525574, 915.0, 1005.0, 915.0, 1005.0, 975.0, 1054.721675395965576, 975.0 ],
					"order" : 1,
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-129", 0 ],
					"midpoints" : [ 486.102734446525574, 915.0, 1005.0, 915.0, 1005.0, 951.0, 1041.626438736915588, 951.0 ],
					"order" : 2,
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-130", 0 ],
					"midpoints" : [ 486.102734446525574, 915.0, 1029.721678137779236, 915.0 ],
					"order" : 3,
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-372", 0 ],
					"midpoints" : [ 1576.166651725769043, 1944.0, 1576.166651725769043, 1944.0 ],
					"source" : [ "obj-370", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-153", 0 ],
					"midpoints" : [ 1576.166651725769043, 2103.0, 1495.4375, 2103.0 ],
					"source" : [ "obj-372", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-164", 0 ],
					"midpoints" : [ 2060.690456628799438, 2106.0, 1973.5625, 2106.0 ],
					"source" : [ "obj-373", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-341", 0 ],
					"midpoints" : [ 1987.961727142333984, 1344.0, 2088.532272934913635, 1344.0 ],
					"order" : 0,
					"source" : [ "obj-374", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-342", 0 ],
					"midpoints" : [ 1987.961727142333984, 1344.0, 2034.016143441200256, 1344.0 ],
					"order" : 1,
					"source" : [ "obj-374", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-343", 0 ],
					"midpoints" : [ 1987.961727142333984, 1323.0, 1987.961727142333984, 1323.0 ],
					"order" : 2,
					"source" : [ "obj-374", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-344", 0 ],
					"midpoints" : [ 1987.961727142333984, 1344.0, 1935.008078336715698, 1344.0 ],
					"order" : 3,
					"source" : [ "obj-374", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-373", 0 ],
					"midpoints" : [ 2060.690456628799438, 1947.0, 2060.690456628799438, 1947.0 ],
					"source" : [ "obj-375", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-279", 0 ],
					"midpoints" : [ 1040.692574501037598, 2631.0, 1432.9375, 2631.0 ],
					"source" : [ "obj-38", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-421", 0 ],
					"midpoints" : [ 680.686456680297852, 327.0, 680.440313776334165, 327.0 ],
					"source" : [ "obj-386", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-118", 0 ],
					"midpoints" : [ 538.102734446525574, 936.090426981449127, 1255.912129521369934, 936.090426981449127 ],
					"order" : 0,
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-119", 0 ],
					"midpoints" : [ 538.102734446525574, 924.185666382312775, 1244.007368922233582, 924.185666382312775 ],
					"order" : 1,
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-120", 0 ],
					"midpoints" : [ 538.102734446525574, 915.0, 1194.0, 915.0, 1194.0, 951.0, 1230.912132263183594, 951.0 ],
					"order" : 2,
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-121", 0 ],
					"midpoints" : [ 538.102734446525574, 915.0, 1219.007371664047241, 915.0 ],
					"order" : 3,
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-374", 0 ],
					"midpoints" : [ 1728.048399388790131, 1287.0, 1987.961727142333984, 1287.0 ],
					"source" : [ "obj-390", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-424", 0 ],
					"midpoints" : [ 554.852741599082947, 168.0, 606.0, 168.0, 606.0, 165.0, 620.106980443000793, 165.0 ],
					"source" : [ "obj-391", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-405", 0 ],
					"midpoints" : [ 1997.266143441200256, 1575.0, 2035.5, 1575.0 ],
					"source" : [ "obj-392", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-392", 0 ],
					"midpoints" : [ 1935.008078336715698, 1527.0, 1997.266143441200256, 1527.0 ],
					"order" : 0,
					"source" : [ "obj-396", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-414", 0 ],
					"midpoints" : [ 1935.008078336715698, 1629.0, 1149.0, 1629.0, 1149.0, 1941.0, 1136.006065726280212, 1941.0 ],
					"order" : 1,
					"source" : [ "obj-396", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-189", 0 ],
					"midpoints" : [ 1263.716913819313049, 2316.0, 1200.0, 2316.0, 1200.0, 2304.0, 1175.125, 2304.0 ],
					"order" : 1,
					"source" : [ "obj-399", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-400", 0 ],
					"midpoints" : [ 1263.716913819313049, 2316.0, 1263.716913819313049, 2316.0 ],
					"order" : 0,
					"source" : [ "obj-399", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 1 ],
					"midpoints" : [ 238.460148453712463, 483.0, 477.068838000297546, 483.0 ],
					"source" : [ "obj-4", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"midpoints" : [ 227.460148453712463, 483.0, 160.068838000297546, 483.0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"midpoints" : [ 1263.716913819313049, 2391.0, 1040.692574501037598, 2391.0 ],
					"source" : [ "obj-400", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-408", 0 ],
					"midpoints" : [ 2035.5, 1767.0, 2012.5, 1767.0 ],
					"source" : [ "obj-402", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-402", 1 ],
					"midpoints" : [ 2140.825379967689514, 1707.0, 2046.0, 1707.0 ],
					"order" : 1,
					"source" : [ "obj-403", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-410", 0 ],
					"midpoints" : [ 2140.825379967689514, 1698.0, 2140.825379967689514, 1698.0 ],
					"order" : 0,
					"source" : [ "obj-403", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-394", 1 ],
					"midpoints" : [ 2035.5, 1629.0, 1997.340335369110107, 1629.0 ],
					"order" : 1,
					"source" : [ "obj-405", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-402", 0 ],
					"midpoints" : [ 2035.5, 1614.0, 2035.5, 1614.0 ],
					"order" : 0,
					"source" : [ "obj-405", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-399", 0 ],
					"midpoints" : [ 2012.5, 2016.0, 1392.0, 2016.0, 1392.0, 2256.0, 1263.716913819313049, 2256.0 ],
					"source" : [ "obj-407", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-407", 0 ],
					"midpoints" : [ 2012.5, 1806.0, 2012.5, 1806.0 ],
					"source" : [ "obj-408", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-109", 0 ],
					"midpoints" : [ 590.102734446525574, 936.090426981449127, 1438.054966688156128, 936.090426981449127 ],
					"order" : 0,
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-110", 0 ],
					"midpoints" : [ 590.102734446525574, 924.185666382312775, 1424.95973002910614, 924.185666382312775 ],
					"order" : 1,
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-111", 0 ],
					"midpoints" : [ 590.102734446525574, 915.0, 1377.0, 915.0, 1377.0, 951.0, 1413.054969429969788, 951.0 ],
					"order" : 2,
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-112", 0 ],
					"midpoints" : [ 590.102734446525574, 915.0, 1401.150208830833435, 915.0 ],
					"order" : 3,
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-418", 0 ],
					"midpoints" : [ 1136.006065726280212, 1980.0, 1076.125, 1980.0 ],
					"source" : [ "obj-414", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-97", 0 ],
					"midpoints" : [ 1076.125, 2037.0, 1086.0, 2037.0, 1086.0, 2109.0, 1050.125, 2109.0 ],
					"source" : [ "obj-418", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-147", 0 ],
					"midpoints" : [ 1325.125, 2049.0, 1325.125, 2049.0 ],
					"source" : [ "obj-419", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-44", 1 ],
					"midpoints" : [ 498.5, 1986.0, 486.0, 1986.0, 486.0, 1947.0, 386.0, 1947.0 ],
					"source" : [ "obj-42", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-425", 1 ],
					"midpoints" : [ 717.440313776334165, 1805.886331140995026, 1264.565193653106689, 1805.886331140995026 ],
					"source" : [ "obj-421", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-386", 0 ],
					"midpoints" : [ 680.440313776334165, 273.0, 680.686456680297852, 273.0 ],
					"source" : [ "obj-424", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-36", 0 ],
					"order" : 1,
					"source" : [ "obj-425", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-504", 0 ],
					"order" : 0,
					"source" : [ "obj-425", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-507", 0 ],
					"order" : 2,
					"source" : [ "obj-425", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 1 ],
					"midpoints" : [ 1254.065193653106689, 3378.0, 1348.353100538253784, 3378.0 ],
					"order" : 3,
					"source" : [ "obj-425", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 0 ],
					"midpoints" : [ 1254.065193653106689, 3378.0, 1319.353100538253784, 3378.0 ],
					"order" : 4,
					"source" : [ "obj-425", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-424", 0 ],
					"midpoints" : [ 620.106980443000793, 150.0, 620.106980443000793, 150.0 ],
					"source" : [ "obj-429", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-100", 0 ],
					"midpoints" : [ 642.102734446525574, 936.090426981449127, 1626.150184154510498, 936.090426981449127 ],
					"order" : 0,
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-101", 0 ],
					"midpoints" : [ 642.102734446525574, 915.0, 1566.0, 915.0, 1566.0, 975.0, 1614.245423555374146, 975.0 ],
					"order" : 1,
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-102", 0 ],
					"midpoints" : [ 642.102734446525574, 915.0, 1566.0, 915.0, 1566.0, 951.0, 1601.150186896324158, 951.0 ],
					"order" : 2,
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-103", 0 ],
					"midpoints" : [ 642.102734446525574, 915.0, 1589.245426297187805, 915.0 ],
					"order" : 3,
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-432", 0 ],
					"midpoints" : [ 620.106980443000793, 66.0, 620.106980443000793, 66.0 ],
					"source" : [ "obj-431", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-429", 0 ],
					"midpoints" : [ 620.106980443000793, 102.0, 620.106980443000793, 102.0 ],
					"source" : [ "obj-432", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-429", 0 ],
					"midpoints" : [ 773.906797885894775, 111.0, 620.106980443000793, 111.0 ],
					"source" : [ "obj-435", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"midpoints" : [ 371.0, 2070.0, 342.0, 2070.0, 342.0, 2157.0, 399.0, 2157.0, 399.0, 2151.0, 404.5, 2151.0 ],
					"order" : 0,
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"midpoints" : [ 371.0, 2070.0, 342.0, 2070.0, 342.0, 2130.0, 392.5, 2130.0 ],
					"order" : 1,
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"midpoints" : [ 371.0, 2070.0, 354.0, 2070.0, 354.0, 2106.0, 377.5, 2106.0 ],
					"order" : 2,
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"midpoints" : [ 371.0, 2079.0, 366.5, 2079.0 ],
					"order" : 3,
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-263", 0 ],
					"midpoints" : [ 694.102734446525574, 1167.726072788238525, 209.499985456466675, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-264", 0 ],
					"midpoints" : [ 694.102734446525574, 915.0, 255.0, 915.0, 255.0, 1011.0, 276.0, 1011.0, 276.0, 1077.0, 219.0, 1077.0, 219.0, 1440.0, 197.171219229698181, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-265", 0 ],
					"midpoints" : [ 694.102734446525574, 1144.438403248786926, 182.102727174758911, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-266", 0 ],
					"midpoints" : [ 694.102734446525574, 915.0, 255.0, 915.0, 255.0, 1011.0, 276.0, 1011.0, 276.0, 1077.0, 207.0, 1077.0, 207.0, 1380.0, 171.143823862075806, 1380.0 ],
					"order" : 3,
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-44", 0 ],
					"midpoints" : [ 444.5, 1998.0, 405.0, 1998.0, 405.0, 1965.0, 371.0, 1965.0 ],
					"source" : [ "obj-46", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-254", 0 ],
					"midpoints" : [ 746.102734446525574, 1167.726072788238525, 398.541067600250244, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-255", 0 ],
					"midpoints" : [ 746.102734446525574, 1011.0, 720.0, 1011.0, 720.0, 1035.0, 708.0, 1035.0, 708.0, 1380.0, 408.0, 1380.0, 408.0, 1440.0, 386.21230137348175, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-256", 0 ],
					"midpoints" : [ 746.102734446525574, 1144.438403248786926, 371.14380931854248, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-257", 0 ],
					"midpoints" : [ 746.102734446525574, 1011.0, 720.0, 1011.0, 720.0, 1035.0, 708.0, 1035.0, 708.0, 1380.0, 361.554768919944763, 1380.0 ],
					"order" : 3,
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-364", 0 ],
					"midpoints" : [ 2567.833308935165405, 1830.0, 1681.375, 1830.0 ],
					"source" : [ "obj-48", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-245", 0 ],
					"midpoints" : [ 798.102734446525574, 1167.726072788238525, 580.732835173606873, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-49", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-246", 0 ],
					"midpoints" : [ 798.102734446525574, 1011.0, 720.0, 1011.0, 720.0, 1035.0, 708.0, 1035.0, 708.0, 1428.0, 585.0, 1428.0, 585.0, 1440.0, 568.404068946838379, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-49", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-247", 0 ],
					"midpoints" : [ 798.102734446525574, 1144.438403248786926, 557.445165634155273, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-49", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-248", 0 ],
					"midpoints" : [ 798.102734446525574, 1011.0, 720.0, 1011.0, 720.0, 1035.0, 708.0, 1035.0, 708.0, 1380.0, 543.746536493301392, 1380.0 ],
					"order" : 3,
					"source" : [ "obj-49", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-391", 0 ],
					"midpoints" : [ 160.068838000297546, 561.0, 531.0, 561.0, 531.0, 138.0, 554.852741599082947, 138.0 ],
					"order" : 0,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"midpoints" : [ 160.068838000297546, 552.0, 160.068838000297546, 552.0 ],
					"order" : 1,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-236", 0 ],
					"midpoints" : [ 850.102734446525574, 1167.726072788238525, 768.404054403305054, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-237", 0 ],
					"midpoints" : [ 850.102734446525574, 915.0, 816.0, 915.0, 816.0, 1011.0, 837.0, 1011.0, 837.0, 1077.0, 783.0, 1077.0, 783.0, 1440.0, 757.445151090621948, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-238", 0 ],
					"midpoints" : [ 850.102734446525574, 1144.438403248786926, 743.746521949768066, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-239", 0 ],
					"midpoints" : [ 850.102734446525574, 915.0, 816.0, 915.0, 816.0, 1011.0, 837.0, 1011.0, 837.0, 1077.0, 732.787618637084961, 1077.0 ],
					"order" : 3,
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-87", 0 ],
					"midpoints" : [ 616.5, 2001.0, 531.0, 2001.0, 531.0, 1959.0, 544.5, 1959.0 ],
					"source" : [ "obj-52", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-227", 0 ],
					"midpoints" : [ 902.102734446525574, 1167.726072788238525, 957.445136547088623, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-53", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-228", 0 ],
					"midpoints" : [ 902.102734446525574, 963.0, 909.0, 963.0, 909.0, 1380.0, 897.0, 1380.0, 897.0, 1440.0, 946.486233234405518, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-53", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-229", 0 ],
					"midpoints" : [ 902.102734446525574, 963.0, 909.0, 963.0, 909.0, 1416.0, 932.787604093551636, 1416.0 ],
					"order" : 2,
					"source" : [ "obj-53", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-230", 0 ],
					"midpoints" : [ 902.102734446525574, 963.0, 909.0, 963.0, 909.0, 1380.0, 921.82870078086853, 1380.0 ],
					"order" : 3,
					"source" : [ "obj-53", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-124", 0 ],
					"midpoints" : [ 637.66902232170105, 2283.0, 627.0, 2283.0, 627.0, 2391.0, 637.66902232170105, 2391.0 ],
					"source" : [ "obj-54", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-218", 0 ],
					"midpoints" : [ 954.102734446525574, 1167.726072788238525, 1146.486218690872192, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-55", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-219", 0 ],
					"midpoints" : [ 954.102734446525574, 1011.0, 1044.0, 1011.0, 1044.0, 1077.0, 1086.0, 1077.0, 1086.0, 1440.0, 1135.527315378189087, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-55", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-220", 0 ],
					"midpoints" : [ 954.102734446525574, 1011.0, 1044.0, 1011.0, 1044.0, 1077.0, 1086.0, 1077.0, 1086.0, 1416.0, 1121.828686237335205, 1416.0 ],
					"order" : 2,
					"source" : [ "obj-55", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-221", 0 ],
					"midpoints" : [ 954.102734446525574, 1011.0, 1044.0, 1011.0, 1044.0, 1077.0, 1110.8697829246521, 1077.0 ],
					"order" : 3,
					"source" : [ "obj-55", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"midpoints" : [ 198.656633496284485, 2715.0, 202.271091461181641, 2715.0 ],
					"source" : [ "obj-56", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-54", 0 ],
					"midpoints" : [ 228.656633496284485, 2256.0, 333.0, 2256.0, 333.0, 2205.0, 637.66902232170105, 2205.0 ],
					"source" : [ "obj-56", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-209", 0 ],
					"midpoints" : [ 1006.102734446525574, 1167.726072788238525, 1328.677986264228821, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-57", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-210", 0 ],
					"midpoints" : [ 1006.102734446525574, 1011.0, 1044.0, 1011.0, 1044.0, 1077.0, 1182.0, 1077.0, 1182.0, 1440.0, 1317.719082951545715, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-57", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-211", 0 ],
					"midpoints" : [ 1006.102734446525574, 1144.438403248786926, 1304.020453810691833, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-57", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-212", 0 ],
					"midpoints" : [ 1006.102734446525574, 1011.0, 1044.0, 1011.0, 1044.0, 1077.0, 1293.061550498008728, 1077.0 ],
					"order" : 3,
					"source" : [ "obj-57", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-61", 0 ],
					"midpoints" : [ 136.5, 2133.0, 176.5, 2133.0 ],
					"source" : [ "obj-58", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-200", 0 ],
					"midpoints" : [ 1058.102734446525574, 1167.726072788238525, 1517.71906840801239, 1167.726072788238525 ],
					"order" : 0,
					"source" : [ "obj-59", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-201", 0 ],
					"midpoints" : [ 1058.102734446525574, 915.0, 1134.0, 915.0, 1134.0, 1011.0, 1218.0, 1011.0, 1218.0, 1077.0, 1458.0, 1077.0, 1458.0, 1440.0, 1506.760165095329285, 1440.0 ],
					"order" : 1,
					"source" : [ "obj-59", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-202", 0 ],
					"midpoints" : [ 1058.102734446525574, 1144.438403248786926, 1493.061535954475403, 1144.438403248786926 ],
					"order" : 2,
					"source" : [ "obj-59", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-203", 0 ],
					"midpoints" : [ 1058.102734446525574, 915.0, 1134.0, 915.0, 1134.0, 1011.0, 1218.0, 1011.0, 1218.0, 1077.0, 1482.102632641792297, 1077.0 ],
					"order" : 3,
					"source" : [ "obj-59", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"midpoints" : [ 160.068838000297546, 699.0, 277.102734446525574, 699.0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 0 ],
					"midpoints" : [ 176.150343179702759, 1077.0, 268.102734446525574, 1077.0 ],
					"source" : [ "obj-60", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-56", 0 ],
					"midpoints" : [ 176.5, 2217.0, 198.656633496284485, 2217.0 ],
					"source" : [ "obj-61", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-61", 0 ],
					"midpoints" : [ 62.5, 2142.0, 176.5, 2142.0 ],
					"source" : [ "obj-62", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-88", 0 ],
					"midpoints" : [ 1128.25, 2211.0, 1104.0, 2211.0, 1104.0, 2073.0, 1204.8125, 2073.0 ],
					"source" : [ "obj-63", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-70", 1 ],
					"midpoints" : [ 268.102734446525574, 1167.0, 297.5, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-70", 0 ],
					"midpoints" : [ 268.102734446525574, 1116.0, 268.5, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 1 ],
					"midpoints" : [ 280.352734446525574, 954.0, 280.352734446525574, 954.0 ],
					"source" : [ "obj-66", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 2 ],
					"midpoints" : [ 292.602734446525574, 978.0, 292.602734446525574, 978.0 ],
					"source" : [ "obj-67", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 3 ],
					"midpoints" : [ 304.852734446525574, 1002.0, 304.852734446525574, 1002.0 ],
					"source" : [ "obj-68", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 4 ],
					"midpoints" : [ 317.102734446525574, 1026.0, 317.102734446525574, 1026.0 ],
					"source" : [ "obj-69", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 340.102734446525574, 744.0 ],
					"order" : 13,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 371.102734446525574, 744.0 ],
					"order" : 12,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 403.102734446525574, 744.0 ],
					"order" : 11,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 434.102734446525574, 744.0 ],
					"order" : 10,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 465.102734446525574, 744.0 ],
					"order" : 9,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 528.102734446525574, 744.0 ],
					"order" : 7,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 497.102734446525574, 744.0 ],
					"order" : 8,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 748.102734446525574, 744.0 ],
					"order" : 0,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 717.102734446525574, 744.0 ],
					"order" : 1,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 685.102734446525574, 744.0 ],
					"order" : 2,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-22", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 654.102734446525574, 744.0 ],
					"order" : 3,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 622.102734446525574, 744.0 ],
					"order" : 4,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 591.102734446525574, 744.0 ],
					"order" : 5,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 559.102734446525574, 744.0 ],
					"order" : 6,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"midpoints" : [ 277.102734446525574, 735.0, 277.102734446525574, 735.0 ],
					"order" : 15,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"midpoints" : [ 277.102734446525574, 744.0, 308.102734446525574, 744.0 ],
					"order" : 14,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 275.75, 1476.0, 240.0, 1476.0, 240.0, 1497.0, 231.0, 1497.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-70", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 268.5, 1476.0, 240.0, 1476.0, 240.0, 1497.0, 231.0, 1497.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-70", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 464.352693319320679, 1380.0, 339.0, 1380.0, 339.0, 1476.0, 357.0, 1476.0, 357.0, 1545.0, 231.0, 1545.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-72", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 457.102693319320679, 1380.0, 339.0, 1380.0, 339.0, 1476.0, 357.0, 1476.0, 357.0, 1545.0, 231.0, 1545.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-72", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 4 ],
					"midpoints" : [ 505.912211775779724, 1026.0, 506.102693319320679, 1026.0 ],
					"source" : [ "obj-73", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 3 ],
					"midpoints" : [ 493.852693319320679, 1002.0, 493.852693319320679, 1002.0 ],
					"source" : [ "obj-74", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 2 ],
					"midpoints" : [ 480.912214517593384, 978.0, 481.602693319320679, 978.0 ],
					"source" : [ "obj-75", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 1 ],
					"midpoints" : [ 469.007453918457031, 954.0, 469.352693319320679, 954.0 ],
					"source" : [ "obj-76", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 1 ],
					"midpoints" : [ 457.102693319320679, 1167.0, 486.102693319320679, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-77", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"midpoints" : [ 457.102693319320679, 1116.0, 457.102693319320679, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-77", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-71", 1 ],
					"midpoints" : [ 1326.603100538253784, 3531.0, 1302.0, 3531.0, 1302.0, 3522.0, 1293.080373764038086, 3522.0 ],
					"source" : [ "obj-78", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-71", 0 ],
					"midpoints" : [ 1319.353100538253784, 3531.0, 1302.0, 3531.0, 1302.0, 3522.0, 1267.080373764038086, 3522.0 ],
					"source" : [ "obj-78", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-105", 0 ],
					"midpoints" : [ 1204.8125, 2166.0, 1204.8125, 2166.0 ],
					"order" : 0,
					"source" : [ "obj-79", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-63", 0 ],
					"midpoints" : [ 1204.8125, 2166.0, 1128.25, 2166.0 ],
					"order" : 1,
					"source" : [ "obj-79", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"midpoints" : [ 277.102734446525574, 783.0, 277.102734446525574, 783.0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 0 ],
					"midpoints" : [ 365.436036705970764, 1077.0, 457.102693319320679, 1077.0 ],
					"source" : [ "obj-80", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 835.447946429252625, 1476.0, 798.0, 1476.0, 798.0, 1497.0, 786.0, 1497.0, 786.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-81", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 828.197946429252625, 1476.0, 798.0, 1476.0, 798.0, 1497.0, 786.0, 1497.0, 786.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-81", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 4 ],
					"midpoints" : [ 877.00746488571167, 1026.0, 877.197946429252625, 1026.0 ],
					"source" : [ "obj-82", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 3 ],
					"midpoints" : [ 865.102704286575317, 1002.0, 864.947946429252625, 1002.0 ],
					"source" : [ "obj-83", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 2 ],
					"midpoints" : [ 852.00746762752533, 978.0, 852.697946429252625, 978.0 ],
					"source" : [ "obj-84", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 1 ],
					"midpoints" : [ 840.102707028388977, 954.0, 837.0, 954.0, 837.0, 1089.0, 840.447946429252625, 1089.0 ],
					"source" : [ "obj-85", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 1 ],
					"midpoints" : [ 828.197946429252625, 1167.0, 857.197946429252625, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"midpoints" : [ 828.197946429252625, 1116.0, 828.197946429252625, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-42", 0 ],
					"midpoints" : [ 544.5, 1986.0, 519.0, 1986.0, 519.0, 1959.0, 498.5, 1959.0 ],
					"order" : 0,
					"source" : [ "obj-87", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 1 ],
					"midpoints" : [ 544.5, 1995.0, 486.0, 1995.0, 486.0, 1959.0, 475.5, 1959.0 ],
					"order" : 1,
					"source" : [ "obj-87", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 0 ],
					"midpoints" : [ 544.5, 1986.0, 519.0, 1986.0, 519.0, 1947.0, 444.5, 1947.0 ],
					"order" : 2,
					"source" : [ "obj-87", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-189", 0 ],
					"midpoints" : [ 1204.8125, 2130.0, 1182.0, 2130.0, 1182.0, 2184.0, 1191.0, 2184.0, 1191.0, 2304.0, 1175.125, 2304.0 ],
					"order" : 1,
					"source" : [ "obj-88", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 0 ],
					"midpoints" : [ 1204.8125, 2130.0, 1204.8125, 2130.0 ],
					"order" : 0,
					"source" : [ "obj-88", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 736.53128981590271, 1077.0, 828.197946429252625, 1077.0 ],
					"source" : [ "obj-89", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-33", 0 ],
					"midpoints" : [ 308.102734446525574, 834.0, 329.102734446525574, 834.0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 647.352728962898254, 1380.0, 339.0, 1380.0, 339.0, 1476.0, 357.0, 1476.0, 357.0, 1545.0, 231.0, 1545.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-90", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 640.102728962898254, 1380.0, 339.0, 1380.0, 339.0, 1476.0, 357.0, 1476.0, 357.0, 1545.0, 231.0, 1545.0, 231.0, 1911.0, 209.499985456466675, 1911.0 ],
					"source" : [ "obj-90", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 4 ],
					"midpoints" : [ 688.9122474193573, 1026.0, 689.102728962898254, 1026.0 ],
					"source" : [ "obj-91", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 3 ],
					"midpoints" : [ 675.817010760307312, 1002.0, 676.852728962898254, 1002.0 ],
					"source" : [ "obj-92", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 2 ],
					"midpoints" : [ 663.912250161170959, 978.0, 664.602728962898254, 978.0 ],
					"source" : [ "obj-93", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 1 ],
					"midpoints" : [ 652.007489562034607, 954.0, 652.352728962898254, 954.0 ],
					"source" : [ "obj-94", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-90", 1 ],
					"midpoints" : [ 640.102728962898254, 1167.0, 669.102728962898254, 1167.0 ],
					"order" : 0,
					"source" : [ "obj-95", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-90", 0 ],
					"midpoints" : [ 640.102728962898254, 1116.0, 640.102728962898254, 1116.0 ],
					"order" : 1,
					"source" : [ "obj-95", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"midpoints" : [ 1050.125, 2391.0, 1040.692574501037598, 2391.0 ],
					"source" : [ "obj-96", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-106", 0 ],
					"midpoints" : [ 1050.125, 2178.0, 1050.125, 2178.0 ],
					"order" : 2,
					"source" : [ "obj-97", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-189", 0 ],
					"midpoints" : [ 1050.125, 2178.0, 1104.0, 2178.0, 1104.0, 2172.0, 1191.0, 2172.0, 1191.0, 2304.0, 1175.125, 2304.0 ],
					"order" : 1,
					"source" : [ "obj-97", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-408", 1 ],
					"midpoints" : [ 1050.125, 2178.0, 1104.0, 2178.0, 1104.0, 1794.0, 1989.0, 1794.0, 1989.0, 1767.0, 2023.0, 1767.0 ],
					"order" : 0,
					"source" : [ "obj-97", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 0 ],
					"midpoints" : [ 547.245596289634705, 1077.0, 640.102728962898254, 1077.0 ],
					"source" : [ "obj-98", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1584.590665698051453, 1622.238436162471771, 209.499985456466675, 1622.238436162471771 ],
					"source" : [ "obj-99", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-277", 0 ],
					"midpoints" : [ 1577.340665698051453, 1622.238436162471771, 209.499985456466675, 1622.238436162471771 ],
					"source" : [ "obj-99", 0 ]
				}

			}
 ],
		"originid" : "pat-8",
		"parameters" : 		{
			"obj-108" : [ "live.gain~[27]", "live.gain~", 0 ],
			"obj-117" : [ "live.gain~[24]", "live.gain~", 0 ],
			"obj-126" : [ "live.gain~[16]", "live.gain~", 0 ],
			"obj-132" : [ "Transp", "Transp", 0 ],
			"obj-143" : [ "live.dial[6]", "live.dial", 0 ],
			"obj-147" : [ "live.dial[4]", "live.dial", 0 ],
			"obj-153" : [ "live.dial[7]", "live.dial", 0 ],
			"obj-160" : [ "live.dial[9]", "live.dial", 0 ],
			"obj-164" : [ "live.dial[10]", "live.dial", 0 ],
			"obj-199" : [ "live.gain~[30]", "live.gain~", 0 ],
			"obj-208" : [ "live.gain~[25]", "live.gain~", 0 ],
			"obj-217" : [ "live.gain~[22]", "live.gain~", 0 ],
			"obj-226" : [ "live.gain~[26]", "live.gain~", 0 ],
			"obj-235" : [ "live.gain~[20]", "live.gain~", 0 ],
			"obj-244" : [ "live.gain~[17]", "live.gain~", 0 ],
			"obj-253" : [ "live.gain~[21]", "live.gain~", 0 ],
			"obj-262" : [ "live.gain~[23]", "live.gain~", 0 ],
			"obj-331" : [ "dial[1]", "dial", 0 ],
			"obj-364" : [ "live.dial[8]", "live.dial", 0 ],
			"obj-368" : [ "live.dial[12]", "live.dial", 0 ],
			"obj-399" : [ "live.dial[11]", "live.dial", 0 ],
			"obj-52" : [ "live.dial[1]", "live.dial", 0 ],
			"obj-70" : [ "live.gain~[31]", "live.gain~", 0 ],
			"obj-72" : [ "live.gain~[29]", "live.gain~", 0 ],
			"obj-78" : [ "live.gain~[1]", "live.gain~[1]", 0 ],
			"obj-81" : [ "live.gain~[18]", "live.gain~", 0 ],
			"obj-88" : [ "live.dial[3]", "live.dial", 0 ],
			"obj-90" : [ "live.gain~[19]", "live.gain~", 0 ],
			"obj-97" : [ "live.dial[2]", "live.dial", 0 ],
			"obj-99" : [ "live.gain~[28]", "live.gain~", 0 ],
			"parameterbanks" : 			{
				"0" : 				{
					"index" : 0,
					"name" : "",
					"parameters" : [ "-", "-", "-", "-", "-", "-", "-", "-" ]
				}

			}
,
			"inherited_shortname" : 1
		}
,
		"dependency_cache" : [  ],
		"autosave" : 0,
		"styles" : [ 			{
				"name" : "rnbodefault",
				"default" : 				{
					"accentcolor" : [ 0.343034118413925, 0.506230533123016, 0.86220508813858, 1.0 ],
					"bgcolor" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
					"bgfillcolor" : 					{
						"angle" : 270.0,
						"autogradient" : 0.0,
						"color" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
						"color1" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
						"color2" : [ 0.263682, 0.004541, 0.038797, 1.0 ],
						"proportion" : 0.39,
						"type" : "color"
					}
,
					"color" : [ 0.929412, 0.929412, 0.352941, 1.0 ],
					"elementcolor" : [ 0.357540726661682, 0.515565991401672, 0.861786782741547, 1.0 ],
					"fontname" : [ "Lato" ],
					"fontsize" : [ 12.0 ],
					"stripecolor" : [ 0.258338063955307, 0.352425158023834, 0.511919498443604, 1.0 ],
					"textcolor_inverse" : [ 0.968627, 0.968627, 0.968627, 1 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "rnbohighcontrast",
				"default" : 				{
					"accentcolor" : [ 0.666666666666667, 0.666666666666667, 0.666666666666667, 1.0 ],
					"bgcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"bgfillcolor" : 					{
						"angle" : 270.0,
						"autogradient" : 0.0,
						"color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"color1" : [ 0.090196078431373, 0.090196078431373, 0.090196078431373, 1.0 ],
						"color2" : [ 0.156862745098039, 0.168627450980392, 0.164705882352941, 1.0 ],
						"proportion" : 0.5,
						"type" : "color"
					}
,
					"clearcolor" : [ 1.0, 1.0, 1.0, 0.0 ],
					"color" : [ 1.0, 0.874509803921569, 0.141176470588235, 1.0 ],
					"editing_bgcolor" : [ 0.258823529411765, 0.258823529411765, 0.258823529411765, 1.0 ],
					"elementcolor" : [ 0.223386004567146, 0.254748553037643, 0.998085916042328, 1.0 ],
					"fontsize" : [ 13.0 ],
					"locked_bgcolor" : [ 0.258823529411765, 0.258823529411765, 0.258823529411765, 1.0 ],
					"selectioncolor" : [ 0.301960784313725, 0.694117647058824, 0.949019607843137, 1.0 ],
					"stripecolor" : [ 0.258823529411765, 0.258823529411765, 0.258823529411765, 1.0 ],
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"textcolor_inverse" : [ 1.0, 1.0, 1.0, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "rnbolight",
				"default" : 				{
					"accentcolor" : [ 0.443137254901961, 0.505882352941176, 0.556862745098039, 1.0 ],
					"bgcolor" : [ 0.796078431372549, 0.862745098039216, 0.925490196078431, 1.0 ],
					"bgfillcolor" : 					{
						"angle" : 270.0,
						"autogradient" : 0.0,
						"color" : [ 0.835294117647059, 0.901960784313726, 0.964705882352941, 1.0 ],
						"color1" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
						"color2" : [ 0.263682, 0.004541, 0.038797, 1.0 ],
						"proportion" : 0.39,
						"type" : "color"
					}
,
					"clearcolor" : [ 0.898039, 0.898039, 0.898039, 1.0 ],
					"color" : [ 0.815686274509804, 0.509803921568627, 0.262745098039216, 1.0 ],
					"editing_bgcolor" : [ 0.898039, 0.898039, 0.898039, 1.0 ],
					"elementcolor" : [ 0.337254901960784, 0.384313725490196, 0.462745098039216, 1.0 ],
					"fontname" : [ "Lato" ],
					"locked_bgcolor" : [ 0.898039, 0.898039, 0.898039, 1.0 ],
					"stripecolor" : [ 0.309803921568627, 0.698039215686274, 0.764705882352941, 1.0 ],
					"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "rnbomonokai",
				"default" : 				{
					"accentcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ],
					"bgcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"bgfillcolor" : 					{
						"angle" : 270.0,
						"autogradient" : 0.0,
						"color" : [ 0.0, 0.0, 0.0, 1.0 ],
						"color1" : [ 0.031372549019608, 0.125490196078431, 0.211764705882353, 1.0 ],
						"color2" : [ 0.263682, 0.004541, 0.038797, 1.0 ],
						"proportion" : 0.39,
						"type" : "color"
					}
,
					"clearcolor" : [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
					"color" : [ 0.611764705882353, 0.125490196078431, 0.776470588235294, 1.0 ],
					"editing_bgcolor" : [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
					"elementcolor" : [ 0.749019607843137, 0.83921568627451, 1.0, 1.0 ],
					"fontname" : [ "Lato" ],
					"locked_bgcolor" : [ 0.976470588235294, 0.96078431372549, 0.917647058823529, 1.0 ],
					"stripecolor" : [ 0.796078431372549, 0.207843137254902, 1.0, 1.0 ],
					"textcolor" : [ 0.129412, 0.129412, 0.129412, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
 ]
	}

}

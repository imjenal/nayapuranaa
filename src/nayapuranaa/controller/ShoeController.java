package nayapuranaa.controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/FootWearService")
public class ShoeController {

	@RequestMapping("/index")
	public String getIndex(ModelMap map) {
		return "shoehome";
	}
}

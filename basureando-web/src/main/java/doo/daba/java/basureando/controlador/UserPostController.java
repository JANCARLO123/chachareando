package doo.daba.java.basureando.controlador;

import doo.daba.java.beans.DaysOfMonthEntries;
import doo.daba.java.beans.UserPost;
import doo.daba.java.persistencia.paginator.Page;
import doo.daba.java.servicio.interfaces.UserPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Gerardo Aquino
 * Date: 16/05/13
 */
@Controller
public class UserPostController {


	@Autowired
	private UserPostService userPostService;
    private SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");



	@RequestMapping(
			value="/post/page/{page}",
			method = RequestMethod.GET
	)
	public String displayAllPosts(@PathVariable int page, ModelMap model) {

		page = page < 0 ? 0 : page;

		Page<UserPost> userEntryPage = this.userPostService.getAllUserPosts(page, false);
        List<UserPost> recentEntries = this.userPostService.getRecentEntries();

		model.addAttribute("userEntryPage", userEntryPage);
		model.addAttribute("recentEntries", recentEntries);

		return "index";

	}



	@RequestMapping(
			value="/post/show/{userAlias}/{entryId}/{entryName}",
			method = RequestMethod.GET
	)
	public String displayUserPost(
            @PathVariable String userAlias,
            @PathVariable int entryId,
            @PathVariable String entryName,
            ModelMap model) {

        Page<UserPost> userEntryPage = new Page<UserPost>();
        List<UserPost> userEntries = new ArrayList<UserPost>();

        List<UserPost> recentEntries = this.userPostService.getRecentEntries();

        userEntries.add(this.userPostService.getUserPost(entryId));
        userEntryPage.setItems(userEntries);

        model.addAttribute("userEntryPage", userEntryPage);
        model.addAttribute("recentEntries", recentEntries);
        
		return "index";
	}




	@RequestMapping(value="/", method = RequestMethod.GET)
	public String getWelcomePage(ModelMap model) {

		return this.displayAllPosts(0, model);

	}



    @ResponseBody
    @RequestMapping(value="/post/calendar/{year}/{month}", method = RequestMethod.GET)
    public DaysOfMonthEntries getPostedDaysList(@PathVariable int year, @PathVariable int month) {
        DaysOfMonthEntries daysOfMonthEntries = null;
        List<Integer> activeDays = null;
        Date dateToEval = null;
        int lastDayOfMonth = 0;

        try {
            dateToEval = this.dateFormatter.parse(String.format("%04d-%02d-%02d", year, month, 1));
        } catch (ParseException e) {
            return new DaysOfMonthEntries(true, "El formato de fecha es incorrecto");
        }

        daysOfMonthEntries = new DaysOfMonthEntries();
        lastDayOfMonth = this.userPostService.getLastDayOfMonth(dateToEval);
        activeDays = this.userPostService.getWhichDaysHasEntries(dateToEval);
        daysOfMonthEntries.setFirstDayPosition(this.userPostService.getFirstDayPosition(dateToEval));

        for(int day = 1; day <= lastDayOfMonth; day++) {
            daysOfMonthEntries.addMonth(day, activeDays.contains(day));
        }

        return daysOfMonthEntries;
    }

}
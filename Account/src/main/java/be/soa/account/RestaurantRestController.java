package be.soa.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/accounts")
public class RestaurantRestController {

    @Autowired
    private RestaurantService restaurantService;

    @GetMapping("")
    public Iterable<Account> getAllAccounts() {
        return restaurantService.getAllAccounts();
    }

    @DeleteMapping("/{id}")
    public void deleteAccount(@PathVariable("id") long id) {
        try {
            restaurantService.deleteAccount(id);
        }
        catch (ServiceException exc) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "restaurant", exc);
        }
    }

    @PostMapping("/add")
    public Iterable<Account> addAccount(@Valid @RequestBody Account account) {
        try {
            restaurantService.addAccount(account);
        }
        catch (ServiceException exc) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "restaurant", exc);
        }
        return restaurantService.getAllAccounts();
    }

    @PutMapping("/{id}")
    public Iterable<Account> updateAccount(@RequestBody Account account, @PathVariable long id) {

        try{
            restaurantService.updateAccount(account, id);
        }catch (ServiceException exc) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "restaurant", exc);
        }
        return restaurantService.getAllAccounts();
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({MethodArgumentNotValidException.class, ResponseStatusException.class})
    public Map<String, String> handleValidationExceptions(Exception ex) {
        Map<String, String> errors = new HashMap<>();
        if (ex instanceof MethodArgumentNotValidException) {
            ((MethodArgumentNotValidException)ex).getBindingResult().getAllErrors().forEach((error) -> {
                String fieldName = ((FieldError) error).getField();
                String errorMessage = error.getDefaultMessage();
                errors.put(fieldName, errorMessage);
            });
        }
        else {
            errors.put(((ResponseStatusException)ex).getReason(), ex.getCause().getMessage());
        }
        return errors;
    }
}

package be.soa.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class RestaurantService {

    @Autowired
    private RestaurantRepository restaurantRepository;

    public Account addAccount(Account account) throws ServiceException {
        return restaurantRepository.save(account);
    }

    public Iterable<Account> getAllAccounts(){
        return restaurantRepository.findAll();
    }

    public Account updateAccount(Account account, long id) throws ServiceException {
        if (restaurantRepository.findAccountById(id) == null)
            throw new ServiceException("Can not update non existing account");
        account.setId(id);
        return restaurantRepository.save(account);
    }

    public void deleteAccount(long id) throws ServiceException {
        if (restaurantRepository.findAccountById(id) == null)
            throw new ServiceException("Can not delete non existing account");
        restaurantRepository.deleteById(id);
    }

    public Account findById(long id){
        return restaurantRepository.findAccountById(id);
    }
}

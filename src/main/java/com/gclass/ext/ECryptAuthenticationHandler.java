package com.gclass.ext;

import org.apache.commons.lang3.StringUtils;
import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.HandlerResult;
import org.jasig.cas.authentication.MessageDescriptor;
import org.jasig.cas.authentication.PreventedException;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.security.auth.login.AccountNotFoundException;
import javax.security.auth.login.FailedLoginException;
import javax.sql.DataSource;
import javax.validation.constraints.NotNull;
import java.security.GeneralSecurityException;
import java.util.List;

/**
 * Created on 16-9-19.
 */
public class ECryptAuthenticationHandler extends AbstractJdbcUsernamePasswordAuthenticationHandler {
    @NotNull
    private String sql;

    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public ECryptAuthenticationHandler() {

    }

    @Override
    protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential credential) throws GeneralSecurityException, PreventedException {
        if (!StringUtils.isBlank(this.sql) && this.getJdbcTemplate() != null) {
            String username = credential.getUsername();
            try {
                String e = (String) this.getJdbcTemplate().queryForObject(this.sql, String.class, new Object[]{username});
                if (!encoder.matches(credential.getPassword(), e)) {
                    throw new FailedLoginException("Password does not match value on record.");
                }
            } catch (IncorrectResultSizeDataAccessException var5) {
                if (var5.getActualSize() == 0) {
                    throw new AccountNotFoundException(username + " not found with SQL query");
                }

                throw new FailedLoginException("Multiple records found for " + username);
            } catch (DataAccessException var6) {
                throw new PreventedException("SQL exception while executing query for " + username, var6);
            }

            return this.createHandlerResult(credential, this.principalFactory.createPrincipal(username), (List<MessageDescriptor>) null);
        } else {
            throw new GeneralSecurityException("Authentication handler is not configured correctly");
        }
    }

    @Autowired
    public void setSql(@Value("${cas.jdbc.authn.query.sql:}") String sql) {
        this.sql = sql;
    }

    @Autowired(
            required = false
    )
    public void setDataSource(@Qualifier("queryDatabaseDataSource") DataSource dataSource) {
        super.setDataSource(dataSource);
    }
}

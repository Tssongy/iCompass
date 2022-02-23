def create_user(first_name, last_name, email, password)
    password_digest = BCrypt::Password.create(password)
    
    run_sql("INSERT INTO users(first_name, last_name, email, password_digest) VALUES($1, $2, $3, $4)", [first_name, last_name, email, password_digest])
    
end

def find_user_by_email(email)
    users = run_sql("SELECT * FROM users WHERE email = $1", [email])

    if users.to_a.count > 0
        users[0]
    else
        nil
    end
end

def find_user_by_id(id)
    run_sql("SELECT * FROM users WHERE id = $1", [id])[0]
end

def find_user_id_by_email(email)
    user_id = run_sql("SELECT id FROM users WHERE email = $1", [email]).to_a[0]['id'].to_i
end

def find_role_by_id(user_id)
    role = run_sql("SELECT role FROM assignments WHERE user_id = $1", [user_id]).to_a[0]
end
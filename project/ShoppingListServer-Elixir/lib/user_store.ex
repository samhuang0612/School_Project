##############################################################################
# Assignment : 5
# Author     : Lishan Huang
# Email      : lhuan22@uwo.ca
# 
# The UserStore module manages a database of users, storing their usernames and passwords
##############################################################################
#import User module
import User

defmodule UserStore do

  # Path to the user database file
  # Don't forget to create this directory if it doesn't exist
  @database_directory "db"

  # Name of the user database file
  @user_database "users.txt"

  # Note: you will spawn a process to run this store in
  # ShoppingListServer.  You do not need to spawn another process here
  def start() do
    # Load your users and start your loop
    loop()
  end

  # Path to the user database
  defp user_database(), do: Path.join(@database_directory, @user_database)

  # Use this function to hash your passwords
  defp hash_password(password) do
    hash = :crypto.hash(:sha256, password)
    Base.encode16(hash)
  end
#begin to loop and determine what to do base on the receive message 
  defp loop() do
    receive do
      {caller,:list}   ->
        list(caller)
        loop()

      {caller, :clear} ->
        _clear(caller)
        loop()

      {caller, :add, username, password} ->
        add(caller,username, password)
        loop()

      {caller, :authenticate, username, password} ->
        authenticate(caller,username, password)
        loop()

      {caller, :exit} ->
        _exit(caller)
      _ ->
        loop()
    end
  end
#clear databse 
  def _clear(caller) do
    File.rm_rf Path.join(@database_directory,@user_database)
    send(caller, {self(), :cleared})
  end
#Retrieves a sorted list of all usernames in the database
  def list(caller) do
    #if file does not exist the create it
    if(File.exists?(user_database()) == false) do  
      File.mkdir_p(@database_directory)
      File.touch!(user_database())
    end
    #read the content from file and store it in content
    stream= File.stream!(user_database())
    content = stream \
      |> Enum.map(&String.trim/1) 
      #split the message in content by : and take the file part and store it in name
    name = for n <- content do List.first(String.split(n, ":")) end
    #send back message with user'sname
    send(caller, {self(), :user_list, name})
  end
  #add user into the file
  def add(caller,username, password) do
    #if file does not eixst the create a file
    if(File.exists?(user_database()) == false) do  
      File.mkdir_p(@database_directory)
      File.touch!(user_database())
    end
    #read the file and store the data in content
    stream= File.stream!(user_database())
    content = stream \
      |> Enum.map(&String.trim/1)
      #take user's name and store in checklist
    checklist = for n <- content do List.first(String.split(n, ":")) end
    #if the target username is not in checklist then add it to content and write into the file
    if(Enum.member?(checklist, username) == false ) do
      #hash the password
      hashPass =  hash_password(password)
      #and the password and user into content
      content = content ++ [username <> ":" <> hashPass] \
          |>Enum.sort() 
          |>Enum.join("\n")
          #put it back to the file
      File.write(user_database(), content)
      #create user moduale to store the name and password
      user = %User{username: username, password: hashPass}
      #return meesage with user
      send(caller, {self(), :added, user})
    else
      #if it is in checklist then return error message
      send(caller, {self(), :error, "User already exists"})
    end
      
  end
#Hashes and Base16-encodes the provided password, comparing it to the user's hashed password in the database
  def authenticate(caller,username, password) do
    #if the file is not exist then return auth_failed
    if(File.exists?(user_database()) == false) do  
      send(caller,{self(), :auth_failed, username})
    else
      #if it exists the check if the password correct or not
    stream= File.stream!(user_database())
    #store data in content
    content = stream \
      |> Enum.map(&String.trim/1)
      #store user's name in checklist
    checklist = for n <- content do List.first(String.split(n, ":")) end
    #store user's password in checklist2
    checklist2 = for n <- content do List.last(String.split(n, ":")) end
    #if the target user is not in checklist then return fail message
    if(Enum.member?(checklist, username) == false ) do
      send(caller, {self(), :auth_failed, username})
    else
      #if it is in check list then check the password correct or not
       index= Enum.find_index(checklist, fn x -> x == username  end)
       #if it is correct then return success else return fail
       if((Enum.at(checklist2, index) == hash_password(password)) ) do
        send(caller,{self(), :auth_success, username})
       else
        send(caller,{self(), :auth_failed, username})
       end
    end
    end
  end
  #shut down process
  defp _exit(caller),do: IO.puts ("UserStore shutting down")

end

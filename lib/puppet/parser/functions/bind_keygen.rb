Puppet::Parser::Functions::newfunction(
  :bind_keygen,
  :type => :rvalue,
  :doc =>
  "bind_keygen(key_file, key_name[, key_length])
   return value: key
   It will generate the key if do not exist.
   It will also generate the directory hierarchy if required.") do |args|
  raise Puppet::ParseError, "Wrong number of arguments" if args.to_a.length < 2 or args.to_a.length > 3

  keygen_util = 'rndc-confgen'

  keyfile = args[0]
  keyname = args[1]
  bits = args[2]

  unless File.exists?(keyfile)
    output = Puppet::Util.execute([keygen_util, '-a', '-c', keyfile, '-k', keyname, '-b', bits])
    raise Puppet::ParseError, "Something went wrong during key generation! Output: #{output}" unless output =~ /wrote key file.*/
  end
  File.read(keyfile)
end

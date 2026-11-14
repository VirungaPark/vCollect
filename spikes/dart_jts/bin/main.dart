import 'dart:io';

Future<void> main() async{
  final result = await Process.run('dart', ['test'], runInShell: true);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exit(result.exitCode);
}
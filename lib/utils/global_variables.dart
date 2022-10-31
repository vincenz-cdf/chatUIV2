import 'package:flutter/material.dart';
import 'package:instalike/screens/add_post_screen.dart';
import 'package:instalike/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile')
];

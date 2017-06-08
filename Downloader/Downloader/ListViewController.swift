//
//  ViewController.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/7/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var pageNumber = 1
    private var pageSize = 10
    private let maxRecords = 50
    
    private let pageinationImageURLList = ["https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                           "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                           "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe",
                                           "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5",
                                           "https://images.unsplash.com/profile-1441738874514-bf742aedca3c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=5ee215da5f36d49fb6432ed1c51bdced",
                                           "https://images.unsplash.com/photo-1464547323744-4edd0cd0c746?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=17b4934ff6fe2e8773896c87aa4ae85b",
                                           "https://images.unsplash.com/profile-1452199439559-1274b6758431?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=61eb2ad46dd9c0e17ae97fa271f7dd7d",
                                           "https://images.unsplash.com/photo-1464545022782-925ec69295ef?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=9af697a854378fe9e922dd8ebc6ec039",
                                           "https://images.unsplash.com/profile-1459198013794-1b8e57737f57?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=03cfd5d0ceeb58f8a2c7fc3a42afead4",
                                           "https://images.unsplash.com/photo-1464537356976-89e35dfa63ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=3e32e4760e959e86133eb08418ed5fc5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536564416-b73260a9532b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=03326914ff00d129abd031d5033c15d5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536194743-0c49f0766ef6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=f1126fb88744998f54efbae390fd7b67",
                                           "https://images.unsplash.com/profile-1464519397431-f860aa18227f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=9563c375f482f24a7024f18c3d0eb14f",
                                           "https://images.unsplash.com/photo-1464519586905-a8c004d307cc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=54ea86802ddc826d8933491d262616af",
                                           "https://images.unsplash.com/profile-1463936441736-1766d7a073d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=11de9ff56c78eee1735d31e687854e65",
                                           "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8cfd7aa940eb30ae2d754704c1ba89b5","https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                           "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                           "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe",
                                           "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5",
                                           "https://images.unsplash.com/profile-1441738874514-bf742aedca3c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=5ee215da5f36d49fb6432ed1c51bdced",
                                           "https://images.unsplash.com/photo-1464547323744-4edd0cd0c746?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=17b4934ff6fe2e8773896c87aa4ae85b",
                                           "https://images.unsplash.com/profile-1452199439559-1274b6758431?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=61eb2ad46dd9c0e17ae97fa271f7dd7d",
                                           "https://images.unsplash.com/photo-1464545022782-925ec69295ef?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=9af697a854378fe9e922dd8ebc6ec039",
                                           "https://images.unsplash.com/profile-1459198013794-1b8e57737f57?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=03cfd5d0ceeb58f8a2c7fc3a42afead4",
                                           "https://images.unsplash.com/photo-1464537356976-89e35dfa63ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=3e32e4760e959e86133eb08418ed5fc5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536564416-b73260a9532b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=03326914ff00d129abd031d5033c15d5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536194743-0c49f0766ef6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=f1126fb88744998f54efbae390fd7b67",
                                           "https://images.unsplash.com/profile-1464519397431-f860aa18227f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=9563c375f482f24a7024f18c3d0eb14f",
                                           "https://images.unsplash.com/photo-1464519586905-a8c004d307cc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=54ea86802ddc826d8933491d262616af",
                                           "https://images.unsplash.com/profile-1463936441736-1766d7a073d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=11de9ff56c78eee1735d31e687854e65",
                                           "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8cfd7aa940eb30ae2d754704c1ba89b5","https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                           "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                           "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe",
                                           "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5",
                                           "https://images.unsplash.com/profile-1441738874514-bf742aedca3c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=5ee215da5f36d49fb6432ed1c51bdced",
                                           "https://images.unsplash.com/photo-1464547323744-4edd0cd0c746?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=17b4934ff6fe2e8773896c87aa4ae85b",
                                           "https://images.unsplash.com/profile-1452199439559-1274b6758431?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=61eb2ad46dd9c0e17ae97fa271f7dd7d",
                                           "https://images.unsplash.com/photo-1464545022782-925ec69295ef?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=9af697a854378fe9e922dd8ebc6ec039",
                                           "https://images.unsplash.com/profile-1459198013794-1b8e57737f57?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=03cfd5d0ceeb58f8a2c7fc3a42afead4",
                                           "https://images.unsplash.com/photo-1464537356976-89e35dfa63ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=3e32e4760e959e86133eb08418ed5fc5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536564416-b73260a9532b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=03326914ff00d129abd031d5033c15d5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536194743-0c49f0766ef6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=f1126fb88744998f54efbae390fd7b67",
                                           "https://images.unsplash.com/profile-1464519397431-f860aa18227f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=9563c375f482f24a7024f18c3d0eb14f",
                                           "https://images.unsplash.com/photo-1464519586905-a8c004d307cc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=54ea86802ddc826d8933491d262616af",
                                           "https://images.unsplash.com/profile-1463936441736-1766d7a073d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=11de9ff56c78eee1735d31e687854e65",
                                           "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8cfd7aa940eb30ae2d754704c1ba89b5","https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                           "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                           "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe",
                                           "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5",
                                           "https://images.unsplash.com/profile-1441738874514-bf742aedca3c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=5ee215da5f36d49fb6432ed1c51bdced",
                                           "https://images.unsplash.com/photo-1464547323744-4edd0cd0c746?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=17b4934ff6fe2e8773896c87aa4ae85b",
                                           "https://images.unsplash.com/profile-1452199439559-1274b6758431?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=61eb2ad46dd9c0e17ae97fa271f7dd7d",
                                           "https://images.unsplash.com/photo-1464545022782-925ec69295ef?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=9af697a854378fe9e922dd8ebc6ec039",
                                           "https://images.unsplash.com/profile-1459198013794-1b8e57737f57?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=03cfd5d0ceeb58f8a2c7fc3a42afead4",
                                           "https://images.unsplash.com/photo-1464537356976-89e35dfa63ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=3e32e4760e959e86133eb08418ed5fc5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536564416-b73260a9532b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=03326914ff00d129abd031d5033c15d5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536194743-0c49f0766ef6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=f1126fb88744998f54efbae390fd7b67",
                                           "https://images.unsplash.com/profile-1464519397431-f860aa18227f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=9563c375f482f24a7024f18c3d0eb14f",
                                           "https://images.unsplash.com/photo-1464519586905-a8c004d307cc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=54ea86802ddc826d8933491d262616af",
                                           "https://images.unsplash.com/profile-1463936441736-1766d7a073d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=11de9ff56c78eee1735d31e687854e65",
                                           "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8cfd7aa940eb30ae2d754704c1ba89b5","https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                           "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                           "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                           "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe",
                                           "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=aff4510c05325ad3c7b07ed7062b10c5",
                                           "https://images.unsplash.com/profile-1441738874514-bf742aedca3c?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=5ee215da5f36d49fb6432ed1c51bdced",
                                           "https://images.unsplash.com/photo-1464547323744-4edd0cd0c746?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=17b4934ff6fe2e8773896c87aa4ae85b",
                                           "https://images.unsplash.com/profile-1452199439559-1274b6758431?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=61eb2ad46dd9c0e17ae97fa271f7dd7d",
                                           "https://images.unsplash.com/photo-1464545022782-925ec69295ef?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=9af697a854378fe9e922dd8ebc6ec039",
                                           "https://images.unsplash.com/profile-1459198013794-1b8e57737f57?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=03cfd5d0ceeb58f8a2c7fc3a42afead4",
                                           "https://images.unsplash.com/photo-1464537356976-89e35dfa63ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=3e32e4760e959e86133eb08418ed5fc5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536564416-b73260a9532b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=03326914ff00d129abd031d5033c15d5",
                                           "https://images.unsplash.com/profile-fb-1464533812-a91a557e646d.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=512955d67915413e3a20fb8fdbfcdc76",
                                           "https://images.unsplash.com/photo-1464536194743-0c49f0766ef6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=f1126fb88744998f54efbae390fd7b67",
                                           "https://images.unsplash.com/profile-1464519397431-f860aa18227f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=9563c375f482f24a7024f18c3d0eb14f",
                                           "https://images.unsplash.com/photo-1464519586905-a8c004d307cc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=54ea86802ddc826d8933491d262616af",
                                           "https://images.unsplash.com/profile-1463936441736-1766d7a073d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=11de9ff56c78eee1735d31e687854e65",
                                           "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8cfd7aa940eb30ae2d754704c1ba89b5"]
    
    private var imageURLList = ["https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=4b142941bfd18159e2e4d166abcd0705",
                                "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2",
                                "https://images.unsplash.com/photo-1464550838636-1a3496df938b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=ea8f203f18a51214459deec7301f177f",
                                "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=ec3c56c2ab6baef5d748cb58ccbc0efe"]
    
    //MARK: TalbleView
    @IBOutlet var tableView:UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    static let cellIdentifier = "ListCellIdentifier"
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingLabel.isHidden = true
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self,
                                      action: #selector(ListViewController.pullToRefreshHandler),
                                      for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func pullToRefreshHandler() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableView Delegate and datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListViewController.cellIdentifier) as! ListTableViewCell
        cell.loadImage(url: URL(string:imageURLList[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "showBigImage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if imageURLList.count == pageinationImageURLList.count
        {
            return
        }
        
        if indexPath.row == imageURLList.count - 1
        {
            self.loadingLabel.isHidden = false
            pageNumber += 1
            //call your data fetcher
            DispatchQueue.global().async {
                sleep(1)
                self.imageURLList = self.getRecordsTillPage(pageNo: self.pageNumber)
                DispatchQueue.main.async {
                    self.loadingLabel.isHidden = true
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //Helper Mehtods
    private func getRecordsTillPage(pageNo:Int) -> [String]
    {
        if (pageNo*pageSize>maxRecords)
        {
            return pageinationImageURLList
        }
        
        let index = pageNo*pageSize
        let subArray = pageinationImageURLList[0...index-1]
        return Array(subArray)
    }
    
    
    //prepare for segue
    private var selectedIndex:Int = -1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let zoomCtl:ImageZoomViewController = segue.destination as! ImageZoomViewController
        zoomCtl.imageURL = imageURLList[selectedIndex]
    }
    
    
}


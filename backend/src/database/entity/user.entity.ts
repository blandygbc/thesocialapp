import { BaseEntity, Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { IsEmail } from "class-validator";
import { PostEntity } from "./post.entity";
import { StoryEntity } from "./story.entity";

@Entity("users")
export class UserEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    id!: string;

    @Column({
        nullable: false
    })
    username!: string;

    @Column({
        nullable: false
    })
    @IsEmail({}, { message: 'Enter a valid email', groups: ['email'] })
    useremail!: string;

    @Column({
        nullable: false
    })
    userpassword!: string;
    @Column({
        nullable: true
    })
    userimage!: string;

    @OneToMany(() => PostEntity, user_posts => user_posts.post_user)
    @JoinColumn()
    user_posts!: PostEntity[];

    @ManyToOne(() => UserEntity, post_user => post_user.user_posts)
    @JoinColumn()
    post_user!: UserEntity;

    @OneToMany(() => StoryEntity, user_story => user_story.story_user)
    @JoinColumn()
    user_story!: StoryEntity[];

    @ManyToOne(() => UserEntity, (story_user) => story_user.user_story)
    @JoinColumn()
    story_user!: UserEntity;

}